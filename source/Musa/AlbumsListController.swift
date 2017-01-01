//
//  AlbumsListController.swift
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

class AlbumsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumsTable: UITableView!
    var selectedRow = 0
    
    // from SEGUE
    var artistAlbums: MPMediaQuery?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        albumsTable.delegate = self
        albumsTable.dataSource = self
    }
    

    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = albumsTable.dequeueReusableCell(withIdentifier: "AlbumsCell", for: indexPath) as?  AlbumsCell {
            let currentLocation = musa.albumsQuerySections()[indexPath.section].range.location
            let albumInfo = musa.albums()[indexPath.row + currentLocation].representativeItem
            cell.updateUI(album: albumInfo!)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musa.albumsQuerySections()[section].range.length
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return musa.albumsQuerySections()[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return musa.albumsSections()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return musa.albumsSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = 0
        
        if indexPath[0] != 0 {
            var i = 0
            while i < indexPath[0] {
                index = index + musa.albumsQuerySections()[i].range.length
                i += 1
            }
        }
        self.selectedRow = index + indexPath[1]
        let albumInfo = musa.albums()[self.selectedRow]
        let albumSongs = musa.getSongsFromAlbum(album: (albumInfo.representativeItem?.albumPersistentID)!)
        performSegue(withIdentifier: "getSongs", sender: albumSongs)
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongsListController {
            if let albumSongs = sender as? MPMediaQuery {
                destination.albumSongs = albumSongs
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
