//
//  PlaylistsCell.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia
//  https://github.com/yuki/Musa
//
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version

import UIKit
import MediaPlayer
import MarqueeLabel

class PlaylistsCell: UITableViewCell {

    @IBOutlet weak var playlistName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playlistName.fadeLength = 30.0
        playlistName.trailingBuffer = 30.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateUI(playlist: MPMediaItem){
        playlistName.text = playlist.artist!
    }
}
