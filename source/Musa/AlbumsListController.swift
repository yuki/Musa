//
//  FirstViewController.swift
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

class AlbumsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumsTable: UITableView!
    var musa = Musa()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        albumsTable.delegate = self
        albumsTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = albumsTable.dequeueReusableCell(withIdentifier: "AlbumsCell", for: indexPath) as?  AlbumsCell {
            let albumInfo = musa.albums[indexPath.item]
            cell.updateUI(album: albumInfo)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musa.albums.count
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
