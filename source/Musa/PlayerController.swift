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
    
    private var _songInfo = MPMediaItem()
    var songInfo: MPMediaItem {
        get {
            return _songInfo
        } set {
            _songInfo = newValue
        }
    }
    
    func getNowPlayingItem() {
        songImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 240, height: 240))
        songName.text = (musicPlayer.nowPlayingItem?.title != nil) ? musicPlayer.nowPlayingItem?.title : ""
        groupName.text = (musicPlayer.nowPlayingItem?.artist != nil) ? musicPlayer.nowPlayingItem?.artist : ""
    }
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    var musicPlayer = MPMusicPlayerController.systemMusicPlayer()
    //var musicCollection = MPMediaItemCollection.init()

    @IBAction func pressPlayButton(_ sender: UIButton) {
        if musicPlayer.playbackState == MPMusicPlaybackState.playing {
            musicPlayer.pause()
            playButton.setTitle("Play", for: UIControlState.normal)
        } else {
            musicPlayer.play()
            playButton.setTitle("Pause", for: UIControlState.normal)
            
        }
    }
    
    @IBOutlet weak var prevButton: UIButton!
    @IBAction func pressPrevButton(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
        
        getNowPlayingItem()
    }

    @IBOutlet weak var nextButton: UIButton!
    @IBAction func pressNextButton(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
        
        getNowPlayingItem()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        musicPlayer.play()
        // FIXME: should not be an static CGSIZE!!!
        songImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 240, height: 240))
        
        songName.text = (musicPlayer.nowPlayingItem?.title != nil) ? musicPlayer.nowPlayingItem?.title : ""
        groupName.text = (musicPlayer.nowPlayingItem?.artist != nil) ? musicPlayer.nowPlayingItem?.artist : ""
        //musicCollection = MPMediaItemCollection.init(items: [songInfo])
        //musicPlayer.setQueue(with: musicCollection)
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerController.getNowPlayingItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        musicPlayer.beginGeneratingPlaybackNotifications()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
