//
//  Musa.swift
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
