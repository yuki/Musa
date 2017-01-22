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

class PlayerViewController: UIViewController {

    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var songCurrentTime: UILabel!
    @IBOutlet weak var songTotalTime: UILabel!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var volumeBar: UISlider!
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //https://developer.apple.com/library/content/documentation/Audio/Conceptual/iPodLibraryAccess_Guide/UsingMediaPlayback/UsingMediaPlayback.html
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.updatePlayerView), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.updatePlayerView), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        
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

}
