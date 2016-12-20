//
//  Musa.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/12/16.
//  Copyright © 2016 Rubén Gómez Olivencia. All rights reserved.
//

import Foundation
import MediaPlayer

class Musa {
    var albums = [MPMediaItem]()
    
    
    init() {
        let qryAlbums = MPMediaQuery.albums()
        qryAlbums.groupingType = MPMediaGrouping.album
        for album in qryAlbums.collections!{
            //album.representativeItem?.artwork.image
            self.albums.append(album.representativeItem!)
        }
        //imageV.image = i.albums[0].artwork?.image(at: imageV.intrinsicContentSize)
    }
}
