//
//  GenresListController.swift
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

class GenresListController: UIViewController {
    
    @IBAction func pressShuffleBarButton(_ sender: UIBarButtonItem) {
        Musa.default.startRandomPlaying(musaQuery: self.ancestor)
    }
    
    var selectedRow = 0
    var fromSegue = false
    var ancestor = "Genres"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        genresTable.delegate = self
//        genresTable.dataSource = self
    }

    
    // MARK: - Table View
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = genresTable.dequeueReusableCell(withIdentifier: "GenresCell", for: indexPath) as?  GenresCell {
//            let currentLocation = Musa.default.getCollectionQuerySections(collection: self.ancestor)[indexPath.section].range.location
//            let songInfo = Musa.default.getCollection(collection: self.ancestor)[indexPath.row + currentLocation].representativeItem
//            cell.updateUI(genre: songInfo!)
//            return cell
//        } else {
//            return UITableViewCell()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Musa.default.getCollectionQuerySections(collection: self.ancestor)[section].range.length
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return Musa.default.getCollectionQuerySections(collection: self.ancestor)[section].title
//    }
//    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return Musa.default.getCollectionSections(collection: self.ancestor)
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Musa.default.getCollectionSectionsCount(collection: self.ancestor)
//    }
//    
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        return index
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var index = 0
//        
//        if indexPath.section != 0 {
//            var i = 0
//            while i < indexPath.section {
//                index = index + Musa.default.getCollectionQuerySections(collection: self.ancestor)[i].range.length
//                i += 1
//            }
//        }
//        
//        self.selectedRow = index + indexPath.row
//        let genreInfo = Musa.default.getCollection(collection: self.ancestor)[self.selectedRow]
//        let genreArtists = Musa.default.search(inCollection: self.ancestor, searchBy: "Genre", search: (genreInfo.representativeItem?.genrePersistentID)!)
//        performSegue(withIdentifier: "getArtists", sender: genreArtists)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    // MARK: - Segues
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ArtistsListController {
//            if let genreArtists = sender as? MPMediaQuery {
//                destination.fromSegue  = true
//                destination.genreArtists = genreArtists
//                destination.ancestor = self.ancestor
//                destination.navigationItem.title = genreArtists.collections?.first?.representativeItem?.genre
//            }
//        }
//    }

    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // show container's table
        if let destination = segue.destination as? ReusableTableViewController {
            destination.fromSegue  = true
            destination.ancestor = self.ancestor
        }
    }

}
