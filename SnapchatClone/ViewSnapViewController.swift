//
//  ViewSnapViewController.swift
//  SnapchatClone
//
//  Created by Mitch Guzman on 3/13/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import UIKit
import SDWebImage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        
    }


}
