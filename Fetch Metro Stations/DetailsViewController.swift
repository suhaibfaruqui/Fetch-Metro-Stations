//
//  DetailsViewController.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 4/28/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var label: UILabel!
    var name = "name"
    var distance = "distance"
    var address = "address"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = name
        distanceLabel.text = distance
        addressLabel.text = address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
