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
    static let `default` = Musa()
    static let `player`  = MPMusicPlayerController.systemMusicPlayer()
    
    var query = [String:MPMediaQuery]()


    private init() {
        self.query["Artists"]       = MPMediaQuery.artists()
        self.query["Albums"]        = MPMediaQuery.albums()
        self.query["Songs"]         = MPMediaQuery.songs()
        self.query["Genres"]        = MPMediaQuery.genres()
        self.query["Compilations"]  = MPMediaQuery.compilations()
        self.query["Playlists"]     = MPMediaQuery.playlists()
        self.query["Composers"]     = MPMediaQuery.composers()
        
        //notifications
        Musa.player.beginGeneratingPlaybackNotifications()
    }
    
    // MARK: - Media Query functions
    
    func getCollection(collection: String) -> [MPMediaItemCollection] {
        return self.query[collection]!.collections ?? []
    }
    
    func getCollectionCount (collection: String) -> Int {
        return self.getCollection(collection: collection).count
    }
    
    func getCollectionQuerySections (collection: String) -> [MPMediaQuerySection]{
        return self.query[collection]!.collectionSections ?? []
    }
    
    func getCollectionSections (collection: String) -> [String] {
        return self.query[collection]!.collectionSections?.map { $0.title } ?? []
    }
    
    func getCollectionSectionsCount (collection: String) -> Int {
        return self.getCollectionSections(collection: collection).count
    }



    // MARK: - SEARCH functions
    
    func search (inCollection: String, searchBy: String, search: MPMediaEntityPersistentID) -> MPMediaQuery? {
        var property = MPMediaItemPropertyArtistPersistentID
        var groupBy = MPMediaGrouping.album
        switch searchBy {
            case "Genre":
                property = MPMediaItemPropertyGenrePersistentID
                groupBy  = MPMediaGrouping.artist
            case "Artist":
                property = MPMediaItemPropertyArtistPersistentID
                groupBy  = MPMediaGrouping.album
            case "Album":
                property = MPMediaItemPropertyAlbumPersistentID
                groupBy  = MPMediaGrouping.title
            //FIXME: how to search by playlist?
            //case "Playlist":
            //    property = MPMediaItemPropertyGenrePersistentID
            case "Compilation":
                property = MPMediaItemPropertyIsCompilation
            default:
                property = MPMediaItemPropertyArtistPersistentID
                groupBy  = MPMediaGrouping.album
        }
        let predicate = MPMediaPropertyPredicate(value: search, forProperty: property)
        self.query[inCollection]!.addFilterPredicate(predicate)
        self.query[inCollection]?.groupingType = groupBy
        
        return self.query[inCollection]
    }
    
    func removeSearch (inCollection: String, searchBy: String, search: MPMediaEntityPersistentID) {
        var property = MPMediaItemPropertyArtistPersistentID
        var groupBy = MPMediaGrouping.album
        switch searchBy {
            case "Genre":
                property = MPMediaItemPropertyGenrePersistentID
                groupBy  = MPMediaGrouping.genre
            case "Artist":
                property = MPMediaItemPropertyArtistPersistentID
                groupBy  = MPMediaGrouping.artist
            case "Album":
                property = MPMediaItemPropertyAlbumPersistentID
                groupBy  = MPMediaGrouping.album
            //FIXME: how to search by playlist?
            //case "Playlist":
            //    property = MPMediaItemPropertyGenrePersistentID
            case "Compilation":
                property = MPMediaItemPropertyIsCompilation
            default:
                property = MPMediaItemPropertyArtistPersistentID
                groupBy  = MPMediaGrouping.album
        }
        let predicate = MPMediaPropertyPredicate(value: search, forProperty: property)
        self.query[inCollection]!.removeFilterPredicate(predicate)
        self.query[inCollection]?.groupingType = groupBy
    }
    
    // MARK: - Player functions
    
    func startPlaying(musaQuery: String, index: Int) {
        Musa.player.stop()
        // FIXME: BUG: there's a warning:
        // [SDKLibrary] Unknown comparison type 109.
        Musa.player.setQueue(with: self.query[musaQuery]!)
        Musa.player.nowPlayingItem = self.query[musaQuery]?.items?[index]
        Musa.player.play()
    }
    
    func nextSong() {
        Musa.player.skipToNextItem()
    }
    
    func previousSong() {
        Musa.player.skipToPreviousItem()
    }

    func playPauseSong() {
        if Musa.player.playbackState == MPMusicPlaybackState.playing {
            Musa.player.pause()
        } else {
            Musa.player.play()
        }
    }
    
    func isPlaying() -> Bool {
        return Musa.player.playbackState == MPMusicPlaybackState.playing
    }
    
    func isStopped() -> Bool {
        return Musa.player.playbackState == MPMusicPlaybackState.stopped
    }


}
