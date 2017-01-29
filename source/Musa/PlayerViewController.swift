//
//  PlayerViewController.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia
//  https://github.com/yuki/Musa
//
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

import UIKit
import MediaPlayer
import MarqueeLabel

class PlayerViewController: UIViewController {

    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var songCurrentTime: UILabel!
    @IBOutlet weak var songTotalTime: UILabel!
    
    @IBOutlet weak var songName: MarqueeLabel!
    @IBOutlet weak var groupName: MarqueeLabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var volumeBar: UISlider!
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var blurEffectView: UIView!
    
    @IBOutlet weak var minimizeButton: UIButton!
    
    @IBAction func pressMinimizeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProgressSlider(_ sender: UISlider) {
        Musa.player.currentPlaybackTime = TimeInterval(progressSlider.value)
    }
    
    @IBAction func pressPrevButton(_ sender: UIButton) {
        Musa.default.previousSong()
    }
    
    @IBAction func pressPlayButton(_ sender: UIButton) {
        Musa.default.playPauseSong()
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        Musa.default.nextSong()
    }
    
    @IBAction func pressShuffleButton(_ sender: UIButton) {
        Musa.default.shuffleSongs()
        updatePlayerView()
    }
    
    @IBAction func pressRepeatButton(_ sender: UIButton) {
        Musa.default.repeatMode()
        updatePlayerView()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MASK: gestures
    @IBOutlet var respondToGesture: UIGestureRecognizer!
    
    func respondToSwipeGesture(_ sender: UIGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                Musa.default.nextSong()
            case UISwipeGestureRecognizerDirection.down:
                self.dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizerDirection.left:
                Musa.default.previousSong()
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                print("III")
                break
            }
        }
    }


    // MARK: show

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        songName.fadeLength = 30.0
        songName.trailingBuffer = 30.0
        groupName.fadeLength = 30.0
        groupName.trailingBuffer = 30.0
        
        // gestures
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        // not used,
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        // take care of buttons
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.isExclusiveTouch = true
            }
        }
        
        //blur effect 
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = self.songImage.bounds
        self.blurEffectView.addSubview(blurView)
        self.blurEffectView.sendSubview(toBack: blurView)
        
        //https://developer.apple.com/library/content/documentation/Audio/Conceptual/iPodLibraryAccess_Guide/UsingMediaPlayback/UsingMediaPlayback.html
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.updatePlayerView), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.updatePlayerView), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        
        // Detect device orientation
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        
        updatePlayerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func updatePlayerView() {
        playButton.setImage(Musa.default.getPlayPauseImage(), for: UIControlState.normal)
        
        // FIXME: should not be an static CGSIZE!!!
        songImage.image = (Musa.player.nowPlayingItem?.artwork != nil) ? Musa.player.nowPlayingItem?.artwork?.image(at: CGSize(width: 240, height: 240)) : UIImage(named: "songs")
        
        songName.text = (Musa.player.nowPlayingItem?.title != nil) ? Musa.player.nowPlayingItem?.title : ""
        groupName.text = (Musa.player.nowPlayingItem?.artist != nil) ? Musa.player.nowPlayingItem?.artist : ""

        let displayLink = CADisplayLink(target: self, selector: (#selector(PlayerViewController.updateSliderProgress)))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        
        progressSlider.maximumValue = Float(Int((Musa.player.nowPlayingItem?.playbackDuration)!))
        
        Musa.default.updateShuffleButton(shuffleButton: shuffleButton)
        Musa.default.updateRepeatButton(repeatButton: repeatButton)
    }
    
    //FIXME: refactor this function
    // the time updates in freak mode :/
    func convert(toMinutes time: TimeInterval) -> String {
        let seconds = Int(time)
        if seconds < 60 {
            if seconds < 10 {
                return "0:0\(seconds)"
            }
            return "0:\(seconds)"
        } else {
            let minutes = Int(time) / 60
            let rest_seconds = Int(seconds) % 60
            if rest_seconds < 10 {
                return "\(minutes):0\(rest_seconds)"
            }
            return "\(minutes):\(rest_seconds)"
        }
    }
    
    func updateSliderProgress(){
        progressSlider.setValue(Float(Musa.player.currentPlaybackTime), animated: true)
        
        songCurrentTime.text = convert(toMinutes: Musa.player.currentPlaybackTime)
        if let duration = Musa.player.nowPlayingItem?.playbackDuration {
            songTotalTime.text = "- \(convert(toMinutes: duration - Musa.player.currentPlaybackTime))"
        } else {
            songTotalTime.text = "-"
        }
    }
    
    func rotated () {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            self.blurEffectView.isHidden = true
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            self.blurEffectView.isHidden = false
        }
    }

}
