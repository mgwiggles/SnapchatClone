//
//  SnapsViewController.swift
//  SnapchatClone
//
//  Created by Mitch Guzman on 3/12/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
