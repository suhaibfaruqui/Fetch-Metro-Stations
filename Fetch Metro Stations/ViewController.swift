//
//  ViewController.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 4/21/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet var mapView: MKMapView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myLocation = CLLocationCoordinate2D()
    var myPresentLocation = CLLocationCoordinate2D()
    var stationsNameArray : NSArray = NSArray()
    var stationsDistanceArray : NSDictionary = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        myLocation = appDelegate.myLocation
        self.reconfigureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func viewDidAppear(animated: Bool) {
        myPresentLocation = appDelegate.myLocation
        if !(myLocation.latitude == myPresentLocation.latitude && myLocation.longitude == myPresentLocation.longitude) {
            myLocation = myPresentLocation
            self.reconfigureView()
        }
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(myLocation, 10000, 10000), animated: true)
    }
    
    //function to reconfigure the map
    func reconfigureView() {
        mapView.removeAnnotations(mapView.annotations)
        stationsNameArray = appDelegate.stationsNameArray
        stationsDistanceArray = appDelegate.stationsDistanceArray
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = myLocation
        dropPin.title = "My Present Location"
        mapView.addAnnotation(dropPin)
        self.addMapAnnotations()
    }
    
    //function to add the annotation
    func addMapAnnotations() {
        for var i = 0; i < stationsNameArray.count; i++ {
            let dropPin = CustomAnnotation()
            let latitude = stationsNameArray.objectAtIndex(i).objectForKey("geometry")?.objectForKey("location")?.objectForKey("lat")!
            let longitude = stationsNameArray.objectAtIndex(i).objectForKey("geometry")?.objectForKey("location")?.objectForKey("lng")!
            let coordinate = CLLocationCoordinate2DMake(latitude as! Double, longitude as! Double)
            dropPin.coordinate = coordinate
            dropPin.number = i
            mapView.addAnnotation(dropPin)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //set the view of annotation
        if annotation.isKindOfClass(CustomAnnotation) {
            let myLocation = annotation as! CustomAnnotation
            myLocation.title = stationsNameArray.objectAtIndex(myLocation.number!).objectForKey("name")! as? String
            myLocation.subtitle = "Driving Distance is : \((stationsDistanceArray.objectForKey("rows")!.objectAtIndex(0).objectForKey("elements")!.objectAtIndex(myLocation.number!).objectForKey("distance")!.objectForKey("text")!) as! String)"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation")
            if (annotationView == nil) {
                annotationView = myLocation.annotationView()
            }
            else {
                annotationView!.annotation = annotation;
            }
            annotationView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            return annotationView;
        }
        else {
            return nil
        }
    }

    
    //function to handle the callout button click
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if !view.annotation!.isKindOfClass(CustomAnnotation) {
            return
        }
        let annotationTapped: CustomAnnotation = (view.annotation as! CustomAnnotation)
        self.performSegueWithIdentifier("detailsView", sender: annotationTapped)
    }
   
    //function for preparing for passing data to detailsview page
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "detailsView") {
            let sendBy = sender as! CustomAnnotation
            let destination = segue.destinationViewController as! DetailsViewController
            destination.name = (sender.title!)!
            destination.distance = (sender.subtitle!)!
            destination.address = "Station Address is : \((stationsDistanceArray.objectForKey("destination_addresses")!.objectAtIndex(sendBy.number!)) as! String)"
        }
    }
}