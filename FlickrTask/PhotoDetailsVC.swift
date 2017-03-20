//
//  PhotoDetailsVC.swift
//  FlickrTask
//
//  Created by Ahmed Elzohry on 3/20/17.
//  Copyright © 2017 MacPro. All rights reserved.
//

import UIKit

class PhotoDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(photo?.id)
    }

}
