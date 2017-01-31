//
//  ReusableTableViewCell.swift
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
import MarqueeLabel
import MediaPlayer

class ReusableTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var trackNumber: UILabel!
    @IBOutlet weak var primaryLabel: MarqueeLabel!
    @IBOutlet weak var secondaryLabel: MarqueeLabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        primaryLabel.fadeLength = 30.0
        secondaryLabel.trailingBuffer = 30.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func updateUI(item: MPMediaItem, ancestor: String, parent: String){
        itemImage.image = (item.artwork != nil) ? item.artwork?.image(at:itemImage.intrinsicContentSize) : UIImage(named: ancestor.lowercased())
        
        switch ancestor {
            case "Artists":
                primaryLabel.text = item.albumArtist
                trackNumber.isHidden = true
                secondaryLabel.isHidden = true
                if parent == "Albums" {
                    primaryLabel.text = item.albumTitle
                }
            case "Albums":
                primaryLabel.text = item.albumTitle
                trackNumber.isHidden = true
                secondaryLabel.isHidden = true
            case "Songs":
                trackNumber.isHidden = true
                primaryLabel.text = item.title
                secondaryLabel.text = "\((item.artist != nil) ? item.artist! : "" ) - \((item.albumTitle != nil) ? item.albumTitle! : "" )"
            case "Compilations":
                primaryLabel.text = item.albumTitle
                trackNumber.isHidden = true
                secondaryLabel.isHidden = true
            case "Composers":
                primaryLabel.text = item.composer
                trackNumber.isHidden = true
                secondaryLabel.isHidden = true
            case "Genres":
                primaryLabel.text = item.genre
                trackNumber.isHidden = true
                secondaryLabel.isHidden = true
                if parent == "Albums"{
                    primaryLabel.text = item.albumTitle
                    secondaryLabel.isHidden = false
                    secondaryLabel.text = item.albumArtist
                }
            default:
                primaryLabel.text = item.title
                trackNumber.isHidden = true
                secondaryLabel.isHidden = true
        }
        
        if parent == "Songs" && ancestor != "Songs" {
            trackNumber.isHidden = false
            itemImage.isHidden = true
            primaryLabel.text = item.title
            trackNumber.text = (item.albumTrackNumber != nil) ? "\(item.albumTrackNumber)" : ""
        }
        
        
        
    }
    
}
