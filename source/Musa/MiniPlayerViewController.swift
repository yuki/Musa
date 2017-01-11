//
//  MiniPlayerViewController.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 10/1/17.
//  Copyright © 2017 Rubén Gómez Olivencia. All rights reserved.
//

import UIKit
import MediaPlayer

class MiniPlayerViewController: UIViewController {
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBAction func tapPlayPauseButton(_ sender: UIButton) {
        Musa.default.playPauseSong()
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        Musa.default.nextSong()
        setVisible()
    }
    
    @IBAction func tapButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.present(storyboard.instantiateViewController(withIdentifier: "PlayerView"), animated: true, completion: nil)
    }

    // MARK: show
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.view.sendSubview(toBack: blurView)
        
        
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
            songImage.image = Musa.player.nowPlayingItem?.artwork?.image(at: CGSize(width: 240, height: 240))
            songNameLabel.text = (Musa.player.nowPlayingItem?.title != nil) ? Musa.player.nowPlayingItem?.title : ""
            
            playPauseButton.setTitle(Musa.default.isPlaying() ? "Pause" : "Play", for: UIControlState.normal)
        }
    }


}
