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

class SongsCell: UITableViewCell {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songGroupAndAlbum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //override func setSelected(_ selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    //}
    
    func updateUI(song: MPMediaItem){
        songImage.image = song.artwork?.image(at: songImage.intrinsicContentSize)
        songTitle.text = song.title
        songGroupAndAlbum.text = "\((song.artist != nil) ? song.artist! : "" ) - \((song.albumTitle != nil) ? song.albumTitle! : "" )"
    }


}
