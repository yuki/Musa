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
    var albumsQuery = MPMediaQuery()
    var songsQuery = MPMediaQuery()


    init() {
        self.artistsQuery = MPMediaQuery.artists()
        self.albumsQuery = MPMediaQuery.albums()
        self.songsQuery = MPMediaQuery.songs()
    }

    // MARK: - ARTISTS functions

    func artists() -> [MPMediaItemCollection] {
        return self.artistsQuery.collections!
    }

    func artistsCount () -> Int {
        return self.artists().count
    }

    func artistsQuerySections () -> [MPMediaQuerySection]{
        return self.artistsQuery.collectionSections!
    }

    func artistsSections () -> [String] {
        return self.artistsQuery.collectionSections!.map { $0.title }
    }

    func artistsSectionsCount () -> Int {
        return self.artistsSections().count
    }

    // MARK: - ALBUMS functions

    func albums () -> [MPMediaItemCollection] {
        return self.albumsQuery.collections!
    }

    func albumsCount () -> Int {
        return self.albums().count
    }

    func albumsQuerySections () -> [MPMediaQuerySection]{
        return self.albumsQuery.collectionSections!
    }

    func albumsSections () -> [String] {
        return self.albumsQuery.collectionSections!.map { $0.title }
    }

    func albumsSectionsCount () -> Int {
        return self.albumsSections().count
    }

    // MARK: - SONGS functions

    func songs () -> [MPMediaItemCollection] {
        return self.songsQuery.collections!
    }

    func songsCount () -> Int {
        return self.songs().count
    }

    func songsQuerySections () -> [MPMediaQuerySection]{
        return self.songsQuery.collectionSections!
    }

    func songsSections () -> [String] {
        return self.songsQuery.collectionSections!.map { $0.title }
    }

    func songsSectionsCount () -> Int {
        return self.songsSections().count
    }




    // MARK: - GET custom functions

    func getAlbumsFromArtist (artist: MPMediaEntityPersistentID) -> MPMediaQuery? {
        let predicateByArtist = MPMediaPropertyPredicate(value: artist, forProperty: MPMediaItemPropertyArtistPersistentID)
        self.albumsQuery.addFilterPredicate(predicateByArtist)
        
        return self.albumsQuery
    }

    func getSongsFromAlbum(album: MPMediaEntityPersistentID)  -> MPMediaQuery? {
        let predicateByAlbum = MPMediaPropertyPredicate(value: album, forProperty: MPMediaItemPropertyAlbumPersistentID)
        self.songsQuery.addFilterPredicate(predicateByAlbum)

        return self.songsQuery
    }


}
