//
//  ComposersListController.swift
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

class ComposersListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var composersTable: UITableView!
    
    var selectedRow = 0
    var fromSegue = false
    var ancestor = "Composers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        composersTable.delegate = self
        composersTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = composersTable.dequeueReusableCell(withIdentifier: "ComposersCell", for: indexPath) as?  ComposersCell {
            let currentLocation = Musa.default.getCollectionQuerySections(collection: self.ancestor)[indexPath.section].range.location
            let songInfo = Musa.default.getCollection(collection: self.ancestor)[indexPath.row + currentLocation].representativeItem
            cell.updateUI(composer: songInfo!)
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
        let composerInfo = Musa.default.getCollection(collection: self.ancestor)[self.selectedRow]
        let composerSongs = Musa.default.search(inCollection: self.ancestor, searchBy: "Composers", search: (composerInfo.representativeItem?.composerPersistentID)!)
        performSegue(withIdentifier: "getSongsFromComposer", sender: composerSongs)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongsListController {
            if let composersSongs = sender as? MPMediaQuery {
                destination.fromSegue  = true
                destination.albumSongs = composersSongs
                destination.ancestor = self.ancestor
                destination.navigationItem.title = composersSongs.collections?.first?.representativeItem?.composer
            }
        }
    }




}
