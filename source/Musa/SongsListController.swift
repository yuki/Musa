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
    var musa = Musa()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        songsTable.delegate = self
        songsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = songsTable.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as?  SongsCell {
            let currentLocation = musa.songsQuery.collectionSections![indexPath.section].range.location
            let songInfo = musa.songs[indexPath.row + currentLocation]
            cell.updateUI(song: songInfo)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musa.songsQuery.itemSections![section].range.length
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return musa.songsQuery.itemSections?[section].title
        //return sections[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return musa.songsQuery.itemSections?.map { $0.title }
        //return sections
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return musa.songsQuery.itemSections!.count
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = 0
        
        if indexPath[0] != 0 {
            var i = 0
            while i < indexPath[0] {
                index = index + musa.songsCollection[i].range.length
                i += 1
            }
        }
        self.selectedRow = index + indexPath[1]
        let songInfo = musa.songs[self.selectedRow]
        
        performSegue(withIdentifier: "PlaySong", sender: songInfo)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination  as? PlayerController {
            if let song = sender as? MPMediaItem {
                destination.songInfo = song
                destination.musicQuery = musa.songsQuery
                destination.musicIndex = self.selectedRow
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
