//
//  ReusableTableViewController.swift
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

class ReusableTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var selectedRow = 0

    // from SEGUE
    var fromSegue = false
    var ancestor = "Reusable"
    var artistAlbums: MPMediaQuery?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib.init(nibName: "ReusableTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableTableCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table View

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath) as?  ReusableTableViewCell {
            let currentLocation = Musa.default.getCollectionQuerySections(collection: self.ancestor)[indexPath.section].range.location
            let itemInfo = Musa.default.getCollection(collection: self.ancestor)[indexPath.row + currentLocation].representativeItem
            cell.updateUI(item: itemInfo!, ancestor: self.ancestor, parent:(self.parent?.title)!)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Musa.default.getCollectionQuerySections(collection: self.ancestor)[section].range.length
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.parent?.title == "Songs" && self.ancestor != "Songs" {
            return ""
        } else {
            return Musa.default.getCollectionQuerySections(collection: self.ancestor)[section].title
        }
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if self.parent?.title == "Songs" && self.ancestor != "Songs" {
            return []
        } else {
            return Musa.default.getCollectionSections(collection: self.ancestor)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Musa.default.getCollectionSectionsCount(collection: self.ancestor)
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = 0

        if indexPath.section != 0 {
            var i = 0
            while i < indexPath.section {
                index = index + Musa.default.getCollectionQuerySections(collection: self.ancestor)[i].range.length
                i += 1
            }
        }

        self.selectedRow = index + indexPath.row
        
        var segueIdentifier = ""
        let itemCollection = Musa.default.getCollection(collection: self.ancestor)[self.selectedRow]
        var items: MPMediaQuery
        
        if self.parent?.title == "Artists" {
            items = Musa.default.search(inCollection: self.ancestor, searchBy: "Artist", search: (itemCollection.representativeItem?.artistPersistentID)!)!
            segueIdentifier = "getAlbums"
            performSegue(withIdentifier: segueIdentifier, sender: items)
        }
        
        if self.parent?.title == "Albums" {
            items = Musa.default.search(inCollection: self.ancestor, searchBy: "Album", search: (itemCollection.representativeItem?.albumPersistentID)!)!
            segueIdentifier = "getSongs"
            performSegue(withIdentifier: segueIdentifier, sender: items)
        }
        
        if self.parent?.title == "Songs" {
            Musa.default.startPlaying(musaQuery: self.ancestor, index: self.selectedRow)
        }
        
        if self.parent?.title == "Compilations" {
            items = Musa.default.search(inCollection: self.ancestor, searchBy: "Compilations", search: (itemCollection.representativeItem?.albumPersistentID)!)!
            segueIdentifier = "getSongs"
            performSegue(withIdentifier: segueIdentifier, sender: items)
        }
        
        if self.parent?.title == "Composers" {
            items = Musa.default.search(inCollection: self.ancestor, searchBy: "Composers", search: (itemCollection.representativeItem?.composerPersistentID)!)!
            segueIdentifier = "getSongs"
            performSegue(withIdentifier: segueIdentifier, sender: items)
        }
        
        if self.parent?.title == "Genres" {
            items = Musa.default.search(inCollection: self.ancestor, searchBy: "Genre", search: (itemCollection.representativeItem?.genrePersistentID)!)!
            segueIdentifier = "getAlbums"
            performSegue(withIdentifier: segueIdentifier, sender: items)
        }
        
        // deselect row
        tableView.deselectRow(at: indexPath, animated: true)
    }



    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumsListController {
            if let artistAlbums = sender as? MPMediaQuery {
                destination.fromSegue  = true
                destination.artistAlbums = artistAlbums
                destination.ancestor = self.ancestor
                destination.navigationItem.title = artistAlbums.collections?.first?.representativeItem?.albumArtist
                if self.parent?.title == "Genres" {
                    destination.navigationItem.title = artistAlbums.collections?.first?.representativeItem?.genre
                }
            }
        }
        
        if let destination = segue.destination as? SongsListController {
            if let albumSongs = sender as? MPMediaQuery {
                destination.fromSegue  = true
                destination.albumSongs = albumSongs
                destination.ancestor = self.ancestor
                destination.navigationItem.title = albumSongs.collections?.first?.representativeItem?.albumTitle
                if self.parent?.title == "Composers" {
                    destination.navigationItem.title = albumSongs.collections?.first?.representativeItem?.composer
                }
            }
        }

    }

}
