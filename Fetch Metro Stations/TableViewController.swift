//
//  TableViewController.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 4/23/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit
import CoreLocation

class TableViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource, UITabBarControllerDelegate {

    @IBOutlet var table: UITableView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var apiKey : String = "AIzaSyD4dwegCF0EPI2iwI7jrnOmPohugtYpyxU"
    var locationManager = CLLocationManager()
    var myLocation = CLLocationCoordinate2D()
    var stationsNameArray : NSArray = NSArray()
    var stationsDistanceArray : NSDictionary = NSDictionary()
    var stationsImageArray : NSMutableArray = NSMutableArray()
    var didFindLocation : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.tabBarController!.tabBar.items![1].enabled = false
        self.findLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    //function for assigning location manager delegates and starting location updation
    func findLocations() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        if locationManager.respondsToSelector("requestWhenInUseAuthorization") {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        didFindLocation = false
    }
    
    //refresh the data as per new location of device
    @IBAction func refreshLocation(sender: AnyObject) {
        self.tabBarController!.tabBar.items![1].enabled = false
        locationManager.startUpdatingLocation()
        didFindLocation = false
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alertController = UIAlertController(title: "Error", message: "Failed to Get Your Location", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let currentLocation: CLLocation? = newLocation
        if currentLocation != nil {
            myLocation.latitude = (currentLocation?.coordinate.latitude)!
            myLocation.longitude = (currentLocation?.coordinate.longitude)!
            appDelegate.myLocation = myLocation
        
            if (didFindLocation == false) {
                self.fetchMetroStations()
                didFindLocation = true
            }
        }
    }
    
    
    //function for searching stations and then loading tableview
    func fetchMetroStations() {
        
        print(myLocation)
        if let stationNameIconData = NSData(contentsOfURL: NSURL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(self.apiKey)&location=\(myLocation.latitude),\(myLocation.longitude)&radius=5000&type=subway_station")!) {
        do {
            let json : NSDictionary = try NSJSONSerialization.JSONObjectWithData(stationNameIconData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            stationsNameArray = json["results"] as! NSArray
            appDelegate.stationsNameArray = stationsNameArray
            self.addStationImages()
        } catch {
            print(error)
        }
        var url : String = "https://maps.googleapis.com/maps/api/distancematrix/json?mode=driving&language=en&key=\(self.apiKey)&origins=\(myLocation.latitude),\(myLocation.longitude)&destinations="
        //Make url for fetching distance
        for var i=0 ; i < stationsNameArray.count ; i++ {
            url += "\(stationsNameArray.objectAtIndex(i).objectForKey("geometry")!.objectForKey("location")!.objectForKey("lat")!),\(stationsNameArray.objectAtIndex(i).objectForKey("geometry")!.objectForKey("location")!.objectForKey("lng")!)|"
        }
        if let stationDistanceData = NSData(contentsOfURL: NSURL(string: url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! as String)!) {
            do {
                let json : NSDictionary = try NSJSONSerialization.JSONObjectWithData(stationDistanceData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                stationsDistanceArray = json
                appDelegate.stationsDistanceArray = stationsDistanceArray
            } catch {
                print(error)
            }
        }
        table.reloadData()
        self.tabBarController!.tabBar.items![1].enabled = true
            
        }
        else {
            let alertController = UIAlertController(title: "Error", message: "Server is not reachable", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsNameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TableViewCell = table.dequeueReusableCellWithIdentifier("cell")! as! TableViewCell
        //cell text properties
        cell.stationName.text = (stationsNameArray.objectAtIndex(indexPath.row).objectForKey("name") as! String)
        cell.drivingDistance.text = "Driving Distance is : \((stationsDistanceArray.objectForKey("rows")!.objectAtIndex(0).objectForKey("elements")!.objectAtIndex(indexPath.row).objectForKey("distance")!.objectForKey("text")!) as! String)"
        cell.address.text = "Station Address is : \((stationsDistanceArray.objectForKey("destination_addresses")!.objectAtIndex(indexPath.row)) as! String)"
        cell.cellImage.image = (stationsImageArray.objectAtIndex(indexPath.row) as! UIImage)
        return cell
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //function for saving images
    func addStationImages() {
        if (stationsImageArray.count > 0) {
            stationsImageArray.removeAllObjects()
        }
       for var i=0; i < stationsNameArray.count; i++ {
            let url = NSURL(string: (stationsNameArray.objectAtIndex(i).objectForKey("icon") as! String))
            let data = NSData(contentsOfURL: url!)
            stationsImageArray.addObject(UIImage(data: data!)!)
        }
        appDelegate.stationsImageArray = stationsImageArray
    }
    
}