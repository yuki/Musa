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
    var songs = [MPMediaItem]()


    init() {
        let qryAlbums = MPMediaQuery.albums()
        qryAlbums.groupingType = MPMediaGrouping.album
        for album in qryAlbums.collections!{
            //album.representativeItem?.artwork.image
            self.albums.append(album.representativeItem!)
        }
        let qrySongs = MPMediaQuery.songs()
        for song in qrySongs.collections!{
            //album.representativeItem?.artwork.image
            self.songs.append(song.representativeItem!)
        }
        
    }
    
    
}
