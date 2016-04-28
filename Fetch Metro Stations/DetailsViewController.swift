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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
