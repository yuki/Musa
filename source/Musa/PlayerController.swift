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
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var groupName: UILabel!
    
    private var _songInfo = MPMediaItem()
    var songInfo: MPMediaItem {
        get {
            return _songInfo
        } set {
            _songInfo = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // FIXME: should not be an static CGSIZE!!!
        songImage.image = songInfo.artwork?.image(at: CGSize(width: 240, height: 240))
        songName.text = (songInfo.title != nil) ? songInfo.title : ""
        groupName.text = (songInfo.artist != nil) ? songInfo.artist : ""
        
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
