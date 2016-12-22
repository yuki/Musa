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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        songsTable.delegate = self
        songsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = songsTable.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as?  SongsCell {
            let songInfo = musa.songs[indexPath.item]
            cell.updateUI(song: songInfo)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musa.songs.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songInfo = musa.songs[indexPath.row]
        performSegue(withIdentifier: "PlaySong", sender: songInfo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination  as? PlayerController {
            if let song = sender as? MPMediaItem {
                destination.songInfo = song
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
