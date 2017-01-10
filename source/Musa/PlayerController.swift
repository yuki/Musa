//
//  PlayerController.swift
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

class PlayerController: UIViewController {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songCurrentTime: UILabel!
    @IBOutlet weak var songTotalTime: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var volumeBar: UISlider!
    
    
    @IBAction func minButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProgresBar(_ sender: UISlider) {
        Musa.player.currentPlaybackTime = TimeInterval(progressSlider.value)
    }
    
    @IBAction func pressPlayButton(_ sender: UIButton) {
        Musa.default.playPauseSong()
    }
    
    @IBAction func pressPrevButton(_ sender: UIButton) {
        Musa.default.previousSong()
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        Musa.default.nextSong()
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

    func getNowPlayingItem() {
        playButton.setTitle(Musa.default.isPlaying() ? "Pause" : "Play", for: UIControlState.normal)
        songImage.image = Musa.player.nowPlayingItem?.artwork?.image(at: CGSize(width: 240, height: 240))
        songName.text = (Musa.player.nowPlayingItem?.title != nil) ? Musa.player.nowPlayingItem?.title : ""
        groupName.text = (Musa.player.nowPlayingItem?.artist != nil) ? Musa.player.nowPlayingItem?.artist : ""
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: should not be an static CGSIZE!!!
        songImage.image = Musa.player.nowPlayingItem?.artwork?.image(at: CGSize(width: 300, height: 300))
        songName.text = (Musa.player.nowPlayingItem?.title != nil) ? Musa.player.nowPlayingItem?.title : ""
        groupName.text = (Musa.player.nowPlayingItem?.artist != nil) ? Musa.player.nowPlayingItem?.artist : ""
        
        //https://developer.apple.com/library/content/documentation/Audio/Conceptual/iPodLibraryAccess_Guide/UsingMediaPlayback/UsingMediaPlayback.html
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerController.getNowPlayingItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerController.getNowPlayingItem), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        
        let displayLink = CADisplayLink(target: self, selector: (#selector(PlayerController.updateSliderProgress)))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        
        progressSlider.maximumValue = Float(Int((Musa.player.nowPlayingItem?.playbackDuration)!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
