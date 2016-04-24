//
//  ViewController.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 4/21/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.cameraWithLatitude(28.6129,
            longitude: 77.2295, zoom: 12)
        mapView.camera = camera
        mapView.myLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(28.6129, 77.2295)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

