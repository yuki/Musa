//
//  AlbumsCell.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/12/16.
//  Copyright © 2016 Rubén Gómez Olivencia. All rights reserved.
//

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
        albumTitle.text = album.albumTitle
        groupName.text = album.albumArtist
    }
}
