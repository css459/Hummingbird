//
//  GenresTableViewController.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit

class GenresTableViewController: UITableViewController {

    // MARK: - Class Properties
    var humm: Humm?
    var backRef: NewRecordingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Humm.genres.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = Humm.genres[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backRef?.newHumm?.genre = Humm.genres[indexPath.row]
//        performSegue(withIdentifier: "toNewRecording", sender: self)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toNewRecording" {
//            let vc = segue.destination as! NewRecordingViewController
//            vc.newHumm = humm
//        }
//    }
}
