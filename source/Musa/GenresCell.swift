//
//  GenresCell.swift
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

class GenresCell: UITableViewCell {

    @IBOutlet weak var genreName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        genreName.fadeLength = 30.0
        genreName.trailingBuffer = 30.0
    }
    
    func updateUI(genre: MPMediaItem){
        genreName.text = genre.genre
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
