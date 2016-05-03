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
        self.drivingDistance.numberOfLines = 0
        self.address.numberOfLines = 0
        self.stationName.numberOfLines = 0
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
