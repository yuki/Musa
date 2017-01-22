//
//  ArtistsCell.swift
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

class ArtistsCell: UITableViewCell {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        artistName.fadeLength = 30.0
        artistName.trailingBuffer = 30.0
    }
    
    func updateUI(artist: MPMediaItem){
        artistImage.image = (artist.artwork != nil) ? artist.artwork?.image(at:artistImage.intrinsicContentSize) : UIImage(named: "artists")

        artistName.text = artist.albumArtist
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
