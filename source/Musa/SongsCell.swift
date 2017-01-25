//
//  SongsCell.swift
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

class SongsCell: UITableViewCell {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: MarqueeLabel!
    @IBOutlet weak var songGroupAndAlbum: MarqueeLabel!
    @IBOutlet weak var songTrackNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        songTitle.fadeLength = 30.0
        songTitle.trailingBuffer = 30.0
        songGroupAndAlbum.fadeLength = 30.0
        songGroupAndAlbum.trailingBuffer = 30.0

    }

    //override func setSelected(_ selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    //}
    
    func updateUI(song: MPMediaItem, ancestor: String){
        songImage.image = (song.artwork != nil) ? song.artwork?.image(at:songImage.intrinsicContentSize) : UIImage(named: "songs")
        songTitle.text = song.title
        songTrackNumber.text = (song.albumTrackNumber != nil) ? "\(song.albumTrackNumber)" : ""
        if ancestor == "Songs" {
            songTrackNumber.isHidden = true
        }
        songGroupAndAlbum.text = "\((song.artist != nil) ? song.artist! : "" ) - \((song.albumTitle != nil) ? song.albumTitle! : "" )"
    }


}
