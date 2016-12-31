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

    @IBOutlet weak var artistsNavigationItem: UINavigationItem!
    @IBOutlet weak var artistsNavigationBar: UINavigationBar!
    @IBOutlet weak var artistsTable: UITableView!
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        artistsTable.delegate = self
        artistsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = artistsTable.dequeueReusableCell(withIdentifier: "ArtistsCell", for: indexPath) as?  ArtistsCell {
            let currentLocation = musa.artistsQuerySections[indexPath.section].range.location
            let songInfo = musa.artists[indexPath.row + currentLocation].representativeItem
            cell.updateUI(artist: songInfo!)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musa.artistsQuerySections[section].range.length
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return musa.artistsQuerySections[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return musa.artistsSections
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return musa.artistsSectionsCount
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = 0
    
        if indexPath[0] != 0 {
            var i = 0
            while i < indexPath[0] {
                index = index + musa.artistsQuerySections[i].range.length
                i += 1
            }
        }
        self.selectedRow = index + indexPath[1]
        let artistInfo = musa.artists[self.selectedRow]
        performSegue(withIdentifier: "getAlbums", sender: artistInfo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumsListController {
            if let artist = sender as? MPMediaQuery {
                //destination.artist = artist
                destination.artistQuery = musa.artists[self.selectedRow]
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
