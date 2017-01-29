//
//  MiniPlayerViewController.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia
//  https://github.com/yuki/Musa
//
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version

import UIKit
import MediaPlayer
import MarqueeLabel

class MiniPlayerViewController: UIViewController {
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songNameLabel: MarqueeLabel!
    
    @IBAction func tapPlayPauseButton(_ sender: UIButton) {
        Musa.default.playPauseSong()
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        Musa.default.nextSong()
        setVisible()
    }
    
    @IBAction func tapButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.present(storyboard.instantiateViewController(withIdentifier: "PlayerViewController"), animated: true, completion: nil)
    }
    
    @IBOutlet var respondToGesture: UIGestureRecognizer!
    
    func respondToSwipeGesture(_ sender: UIGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                Musa.default.nextSong()
            case UISwipeGestureRecognizerDirection.left:
                Musa.default.previousSong()
            default:
                print("III")
                break
            }
        }
    }

    // MARK: show
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let effect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.view.sendSubview(toBack: blurView)
        
        songNameLabel.fadeLength = 30.0
        songNameLabel.trailingBuffer = 30.0
        
        // gestures
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        // take care of buttons
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.isExclusiveTouch = true
            }
        }

        // Notifications
        
        NotificationCenter.default.addObserver(self, selector: #selector(MiniPlayerViewController.setVisible), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MiniPlayerViewController.setVisible), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
        setVisible()
        
        // Do any additional setup after loading the view.
    }
    
    func setVisible() -> Void{
        if Musa.default.isStopped() {
            self.view.isHidden = true
        } else {
            self.view.isHidden = false
            songImage.image = (Musa.player.nowPlayingItem?.artwork != nil) ? Musa.player.nowPlayingItem?.artwork?.image(at:songImage.intrinsicContentSize) : UIImage(named: "songs")

            songNameLabel.text = (Musa.player.nowPlayingItem?.title != nil) ? Musa.player.nowPlayingItem?.title : ""
            
            playPauseButton.setImage(Musa.default.getPlayPauseImage(), for: UIControlState.normal)
        }
    }


}
