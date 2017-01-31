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
    static let `player`  = MPMusicPlayerController.systemMusicPlayer
    
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
    
    func getPrueba (collection: String) -> [MPMediaQuerySection]{
        var array: [MPMediaQuerySection] = []
        for item in self.query[collection]!.collectionSections! {
            array.append(item)
        }
        return array
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
            case "Playlists":
                property = MPMediaPlaylistPropertyPersistentID
                groupBy  = MPMediaGrouping.title
            case "Compilations":
                property = MPMediaItemPropertyAlbumPersistentID
                groupBy = MPMediaGrouping.title
            case "Composers":
                property = MPMediaItemPropertyComposerPersistentID
                groupBy = MPMediaGrouping.title
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
            case "Playlist":
                property = MPMediaItemPropertyAlbumPersistentID
                groupBy  = MPMediaGrouping.playlist
            case "Compilations":
                property = MPMediaItemPropertyAlbumPersistentID
                groupBy = MPMediaGrouping.album
            case "Composers":
                property = MPMediaItemPropertyComposerPersistentID
                groupBy = MPMediaGrouping.composer
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
        Musa.player.shuffleMode = MPMusicShuffleMode.off
        Musa.player.play()
    }
    
    func startRandomPlaying(musaQuery: String) {
        let count = (self.query[musaQuery]?.items?.count)!
        let idx = Int(arc4random_uniform(UInt32(count)))
        self.startPlaying(musaQuery: musaQuery, index: idx)
        Musa.player.shuffleMode = MPMusicShuffleMode.songs
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

    func getPlayPauseImage() -> UIImage {
        if Musa.player.playbackState == MPMusicPlaybackState.playing {
            return UIImage(named: "pause")!
        } else {
            return UIImage(named: "play")!
        }
    }

    func shuffleSongs() {
        if Musa.player.shuffleMode == MPMusicShuffleMode.off {
            Musa.player.shuffleMode = MPMusicShuffleMode.songs
        } else {
            Musa.player.shuffleMode = MPMusicShuffleMode.off
        }
    }

    func isShuffle() -> Bool {
        return Musa.player.shuffleMode == MPMusicShuffleMode.songs
    }

    func updateShuffleButton(shuffleButton: UIButton) {
        if Musa.player.shuffleMode == MPMusicShuffleMode.off {
            shuffleButton.tintColor = UIColor(red: 0/255, green: 121/255, blue: 255/255, alpha: 1)
            shuffleButton.backgroundColor = UIColor.white
        } else {
            shuffleButton.tintColor = UIColor.white
            shuffleButton.backgroundColor = UIColor(red: 0/255, green: 121/255, blue: 255/255, alpha: 1)
        }
    }

    func repeatMode() {
        if Musa.player.repeatMode == MPMusicRepeatMode.none {
            Musa.player.repeatMode = MPMusicRepeatMode.all
        } else if Musa.player.repeatMode == MPMusicRepeatMode.all {
            Musa.player.repeatMode = MPMusicRepeatMode.one
        } else {
            Musa.player.repeatMode = MPMusicRepeatMode.none
        }
    }

    func updateRepeatButton(repeatButton: UIButton) {
        if Musa.player.repeatMode == MPMusicRepeatMode.none {
            repeatButton.tintColor = UIColor(red: 0/255, green: 121/255, blue: 255/255, alpha: 1)
            repeatButton.backgroundColor = UIColor.white
            repeatButton.setBackgroundImage(UIImage(named: "repeat")!, for: UIControlState.normal)
        } else if Musa.player.repeatMode == MPMusicRepeatMode.one {
            repeatButton.tintColor = UIColor.white
            repeatButton.backgroundColor = UIColor(red: 0/255, green: 121/255, blue: 255/255, alpha: 1)
            repeatButton.setBackgroundImage(UIImage(named: "repeat-one")!, for: UIControlState.normal)
        } else {
            repeatButton.tintColor = UIColor.white
            repeatButton.backgroundColor = UIColor(red: 0/255, green: 121/255, blue: 255/255, alpha: 1)
            repeatButton.setBackgroundImage(UIImage(named: "repeat")!, for: UIControlState.normal)
        }
    }

}
