//
//  ComposersCell.swift
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

class ComposersCell: UITableViewCell {

    @IBOutlet weak var composersName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        composersName.fadeLength = 30.0
        composersName.trailingBuffer = 30.0
    }
    
    func updateUI(composer: MPMediaItem){
        composersName.text = composer.composer!
    }

}
