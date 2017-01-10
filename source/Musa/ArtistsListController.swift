//
//  ArtistsListController.swift
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
import MediaPlayer

class ArtistsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var artistsTable: UITableView!
    
    var selectedRow = 0
    var fromSegue = false
    var ancestor = "Artists"
    var genreArtists: MPMediaQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        artistsTable.delegate = self
        artistsTable.dataSource = self
    }

    
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = artistsTable.dequeueReusableCell(withIdentifier: "ArtistsCell", for: indexPath) as?  ArtistsCell {
            let currentLocation = Musa.default.getCollectionQuerySections(collection: self.ancestor)[indexPath.section].range.location
            let songInfo = Musa.default.getCollection(collection: self.ancestor)[indexPath.row + currentLocation].representativeItem
            cell.updateUI(artist: songInfo!)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Musa.default.getCollectionQuerySections(collection: self.ancestor)[section].range.length
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Musa.default.getCollectionQuerySections(collection: self.ancestor)[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Musa.default.getCollectionSections(collection: self.ancestor)
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
        let artistInfo = Musa.default.getCollection(collection: self.ancestor)[self.selectedRow]
        let artistAlbums = Musa.default.search(inCollection: self.ancestor, searchBy: "Artist", search: (artistInfo.representativeItem?.artistPersistentID)!)
        performSegue(withIdentifier: "getAlbums", sender: artistAlbums)
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
                
            }
        }
    }
    
    // MARK: Go back.
    override func didMove(toParentViewController parent: UIViewController?) {
        if (!(parent?.isEqual(self.parent) ?? false)) {
            Musa.default.removeSearch(inCollection: self.ancestor, searchBy: "Genre", search: (genreArtists?.items?.first?.genrePersistentID)!)
        }
    }


}
