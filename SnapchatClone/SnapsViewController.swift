//
//  SnapsViewController.swift
//  SnapchatClone
//
//  Created by Mitch Guzman on 3/12/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            let snapshotURL = snapshot.childSnapshot(forPath: "imageURL")
            let snapshotFrom = snapshot.childSnapshot(forPath: "from")
            let snapshotDescrip = snapshot.childSnapshot(forPath: "description")
            let snapshotUUID = snapshot.childSnapshot(forPath: "uuid")
            
            /* Had to come up with some clever string manipulation to get emails displayed properly.
             Probably a better way to do it, but this works
             */
            
            let snap = Snap()
            let fullURL = "\(snapshotURL)"
            let fullFrom = "\(snapshotFrom)"
            let fullDescrip = "\(snapshotDescrip)"
            let fullUUID="\(snapshotUUID)"
            
            snap.imageURL = fullURL.replacingOccurrences(of: "Snap (imageURL) ", with: "")
            snap.from = fullFrom.replacingOccurrences(of: "Snap (from) ", with: "")
            snap.descrip = fullDescrip.replacingOccurrences(of: "Snap (description) ", with: "")
            snap.key = snapshot.key
            snap.uuid = fullUUID.replacingOccurrences(of: "Snap (uuid) ", with: "")
            
            
            self.snaps.append(snap)
            self.tableView.reloadData()
            
        })
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index = 0
            
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
            self.tableView.reloadData()
            
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        } else {
            
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            
            cell.textLabel?.text = "You have no snap 😔"
            
        } else {
            
            let snap = snaps[indexPath.row]
            
            cell.textLabel?.text = snap.from
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue" {
            
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
            
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
