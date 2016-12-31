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
    var artistsQuery = MPMediaQuery()
    var artists = [MPMediaItemCollection]()
    var artistsCount: Int = 0
    var artistsQuerySections = [MPMediaQuerySection]()
    var artistsSections: [String]?
    var artistsSectionsCount: Int = 0
    
    var albumsQuery = MPMediaQuery()
    var albums = [MPMediaItemCollection]()
    var albumsCount: Int = 0
    var albumsQuerySections = [MPMediaQuerySection]()
    var albumsSections: [String]?
    var albumsSectionsCount: Int = 0
    
    var songs = [MPMediaItem]()
    var songsCollection = [MPMediaQuerySection]()
    var songsQuery = MPMediaQuery()


    init() {
        self.artistsQuery = MPMediaQuery.artists()
        //artists
        self.artists = self.artistsQuery.collections!
        self.artistsCount = self.artists.count
        
        //to know the range of the sections
        self.artistsQuerySections =  self.artistsQuery.collectionSections!
        //sections titles
        self.artistsSections = self.artistsQuerySections.map { $0.title }
        self.artistsSectionsCount = (self.artistsSections?.count)!
        

        self.albumsQuery = MPMediaQuery.albums()
        self.albums = self.albumsQuery.collections!
        self.albumsCount = self.albums.count
        //to know the range of the sections
        self.albumsQuerySections =  self.albumsQuery.collectionSections!
        //sections titles
        self.albumsSections = self.albumsQuerySections.map { $0.title }
        self.albumsSectionsCount = (self.albumsSections?.count)!
        

        self.songsQuery = MPMediaQuery.songs()
        if (self.songsQuery.items?.count)! > 0 {
            for song in self.songsQuery.collections!{
                //album.representativeItem?.artwork.image
                self.songs.append(song.representativeItem!)
            }
            self.songsCollection = self.songsQuery.collectionSections!
        }
    }
    
    
}
