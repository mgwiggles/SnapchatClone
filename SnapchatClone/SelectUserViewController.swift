//
//  SelectUserViewController.swift
//  SnapchatClone
//
//  Created by Mitch Guzman on 3/12/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    
    var descrip = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
        print(snapshot.childSnapshot(forPath: "email"))
            let snapshotEmail = snapshot.childSnapshot(forPath: "email")
        
            /* Had to come up with some clever string manipulation to get emails displayed properly.
            Probably a better way to do it, but this works
            */
            
            let user = User()
            let fullEmail = "\(snapshotEmail)"
            
            user.email = fullEmail.replacingOccurrences(of: "Snap (email) ", with: "")
            
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let snap = ["from":user.email, "description":descrip, "imageURL":imageURL]
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }


}
