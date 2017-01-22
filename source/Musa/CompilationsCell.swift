//
//  CompilationsCell.swift
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

class CompilationsCell: UITableViewCell {

    @IBOutlet weak var compilationName: MarqueeLabel!
    @IBOutlet weak var compilationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        compilationName.fadeLength = 30.0
        compilationName.trailingBuffer = 30.0
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func updateUI(compilation: MPMediaItem){
        compilationName.text = compilation.albumTitle
        compilationImage.image = compilation.artwork?.image(at: compilationImage.intrinsicContentSize)
    }
}
