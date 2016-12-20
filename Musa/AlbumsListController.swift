//
//  FirstViewController.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/12/16.
//  Copyright © 2016 Rubén Gómez Olivencia. All rights reserved.
//

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

