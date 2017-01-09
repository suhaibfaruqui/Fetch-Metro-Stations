//
//  CustomAnnotation.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 4/26/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var title : String? = "title"
    var subtitle : String? = "subtitle"
    var number : Int? = 0
    
    func annotationView() -> MKAnnotationView {
        let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: "CustomAnnotation")
        annotationView.enabled = true
        annotationView.canShowCallout = false
        annotationView.image = UIImage(named: "map_pin")
        return annotationView
    }
    
}