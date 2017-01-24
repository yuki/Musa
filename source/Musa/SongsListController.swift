//
//  SongsListController.swift
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

class SongsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var songsTable: UITableView!
    
    @IBAction func pressShuffleBarButton(_ sender: UIBarButtonItem) {
        Musa.default.startRandomPlaying(musaQuery: self.ancestor)
    }
    
    @IBAction func pressPlayBarButton(_ sender: UIBarButtonItem) {
        Musa.default.startPlaying(musaQuery: self.ancestor, index: 0)
        print(self.ancestor)
    }
    
    var selectedRow = 0
    
    // from SEGUE
    var fromSegue = false
    var ancestor = "Songs"
    var albumSongs: MPMediaQuery?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        songsTable.delegate = self
        songsTable.dataSource = self
    }
    

    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = songsTable.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as?  SongsCell {
            let currentLocation = Musa.default.getCollectionQuerySections(collection: self.ancestor)[indexPath.section].range.location
            let songInfo = Musa.default.getCollection(collection: self.ancestor)[indexPath.row + currentLocation].representativeItem
            cell.updateUI(song: songInfo!)
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
        
        if indexPath[0] != 0 {
            var i = 0
            while i < indexPath[0] {
                index = index + Musa.default.getCollectionQuerySections(collection: self.ancestor)[i].range.length
                i += 1
            }
        }
        self.selectedRow = index + indexPath[1]
        tableView.deselectRow(at: indexPath, animated: true)
        
        Musa.default.startPlaying(musaQuery: self.ancestor, index: self.selectedRow)
    }
    
    // MARK: Go back.
    override func didMove(toParentViewController parent: UIViewController?) {
        if (!(parent?.isEqual(self.parent) ?? false)) {
            var searchBy = "Album"
            var search = albumSongs?.items?.first?.albumPersistentID
            switch self.ancestor {
                case "Composers":
                    searchBy = "Composers"
                    search = albumSongs?.items?.first?.composerPersistentID
                default:
                    searchBy = "Album"
                    search = albumSongs?.items?.first?.albumPersistentID
            }
            Musa.default.removeSearch(inCollection: self.ancestor, searchBy: searchBy, search: search!)
        }
    }

}
