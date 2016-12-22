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

class AlbumsCell: UITableViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var groupName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(album: MPMediaItem){
        albumImage.image = album.artwork?.image(at: albumImage.intrinsicContentSize)
        albumTitle.text = album.albumTitle!
        groupName.text = album.artist!
    }
}
