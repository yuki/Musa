//
//  AlbumsCell.swift
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

class AlbumsCell: UITableViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: MarqueeLabel!
    @IBOutlet weak var groupName: MarqueeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumTitle.fadeLength = 30.0
        albumTitle.trailingBuffer = 30.0

        groupName.fadeLength = 30.0
        groupName.trailingBuffer = 30.0

    }

    func updateUI(album: MPMediaItem){
        albumImage.image = (album.artwork != nil) ? album.artwork?.image(at:albumImage.intrinsicContentSize) : UIImage(named: "albums")
        albumTitle.text = album.albumTitle!
        groupName.text = album.artist!
    }
}
