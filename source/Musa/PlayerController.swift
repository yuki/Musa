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
    
    
    //var musicPlayer = MPMusicPlayerController.systemMusicPlayer()
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
    var musicQuery = musa.songsQuery
    var musicIndex: Int = 0
    
    
    @IBAction func changeProgresBar(_ sender: UISlider) {
        musicPlayer.currentPlaybackTime = TimeInterval(progressSlider.value)
    }
    
    @IBAction func pressPlayButton(_ sender: UIButton) {
        if musicPlayer.playbackState == MPMusicPlaybackState.playing {
            musicPlayer.pause()
            playButton.setTitle("Play", for: UIControlState.normal)
        } else {
            musicPlayer.play()
            playButton.setTitle("Pause", for: UIControlState.normal)
            
        }
    }
    
    @IBAction func pressPrevButton(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
        getNowPlayingItem()
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
        getNowPlayingItem()
    }
    
    
    //FIXME: refactor this function
    // the time updates in freak mode :/
    func toMinutes(time: TimeInterval) -> String{
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
        songImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 240, height: 240))
        songName.text = (musicPlayer.nowPlayingItem?.title != nil) ? musicPlayer.nowPlayingItem?.title : ""
        groupName.text = (musicPlayer.nowPlayingItem?.artist != nil) ? musicPlayer.nowPlayingItem?.artist : ""
    }
    
    func updateSliderProgress(){
        progressSlider.setValue(Float(musicPlayer.currentPlaybackTime), animated: true)

        songCurrentTime.text = toMinutes(time: musicPlayer.currentPlaybackTime)
        songTotalTime.text = "- \(toMinutes(time:((musicPlayer.nowPlayingItem?.playbackDuration)! - musicPlayer.currentPlaybackTime)))"
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayer.stop()
        musicPlayer.setQueue(with: musicQuery)
        musicPlayer.nowPlayingItem = musicQuery.items?[musicIndex]
        musicPlayer.play()
        
        
        // FIXME: should not be an static CGSIZE!!!
        songImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 300, height: 300))
        songName.text = (musicPlayer.nowPlayingItem?.title != nil) ? musicPlayer.nowPlayingItem?.title : ""
        groupName.text = (musicPlayer.nowPlayingItem?.artist != nil) ? musicPlayer.nowPlayingItem?.artist : ""
        
        //https://developer.apple.com/library/content/documentation/Audio/Conceptual/iPodLibraryAccess_Guide/UsingMediaPlayback/UsingMediaPlayback.html
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerController.getNowPlayingItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        // FIXME: MPMusicPlayerControllerPlaybackStateDidChangeNotification
        // beginGeneratingPlaybackNotifications
        
        let displayLink = CADisplayLink(target: self, selector: (#selector(PlayerController.updateSliderProgress)))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        musicPlayer.beginGeneratingPlaybackNotifications()
        progressSlider.maximumValue = Float(Int((musicPlayer.nowPlayingItem?.playbackDuration)!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
