//
//  TableViewCell.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 4/24/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var stationName: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var drivingDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor.blueColor()
        self.drivingDistance.numberOfLines = 0
        //self.drivingDistance.backgroundColor = UIColor.lightGrayColor()
        self.address.numberOfLines = 0
        //self.address.backgroundColor = UIColor.greenColor()
        self.stationName.numberOfLines = 0
        //self.stationName.backgroundColor = UIColor.redColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
