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

class ComposersListController: UIViewController {

    @IBAction func pressShuffleBarButton(_ sender: UIBarButtonItem) {
        Musa.default.startRandomPlaying(musaQuery: self.ancestor)
    }

    var selectedRow = 0
    var fromSegue = false
    var ancestor = "Composers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // show container's table
        if let destination = segue.destination as? ReusableTableViewController {
            destination.fromSegue  = true
            destination.ancestor = self.ancestor
        }
    }



}
