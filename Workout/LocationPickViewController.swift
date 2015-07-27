//
//  LocationPickViewController.swift
//  Workout
//
//  Created by 赵雨 on 7/24/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol LocationPickViewControllerDelegate: class {
    func LocationPickerView(LocationPickView picker: LocationPickViewController, didPickedLocation location: String)
}

// TODO: Too muddy!

class LocationPickViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var updatingLocation = false
    var location: CLLocation?
    var lastLocationError: NSError?
    var placemark: CLPlacemark?
    
    var pickedLocation = ""
    
    var timer: NSTimer?
    
    var geocoder = CLGeocoder()
    var lastGeocodingError: NSError?
    var performingReverseGeocoding = false
    
    var pointAnnotation = MKPointAnnotation()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var checkedButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
   
    
    @IBAction func pickLocation(sender: AnyObject) {
        hideButtons()
    }

    @IBAction func CancelLocation(sender: AnyObject) {
        mapView.deselectAnnotation(pointAnnotation, animated: true)
        hideButtons()
    
    }
    
    @IBAction func myLocation(sender: AnyObject) {
        // TODO: retrive previous location if exist
        println("myLocation: lat:\(location!.coordinate.latitude), long:\(location!.coordinate.latitude)")
        pointAnnotation.coordinate = location!.coordinate
        
        println("placemark: \(stringForPlacemark(placemark!))")
        pointAnnotation.title = stringForPlacemark(placemark!)
        
        mapView.removeAnnotation(pointAnnotation)
        setReigonForCoordinate(pointAnnotation.coordinate)
        mapView.addAnnotation(pointAnnotation)
        
    }
    
    func showButtons() {
        checkedButton.hidden = false
        cancelButton.hidden = false
    }
    
    func hideButtons() {
        checkedButton.hidden = true
        cancelButton.hidden = true
    }
    
    func setReigonForCoordinate(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disable", message: "Please enable locations services for this app in Settings", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == .NotDetermined {
            println("AuthStatus NotDetermined")
            locationManager.requestWhenInUseAuthorization()
        }
        
        if authStatus == .Denied || authStatus == .Restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        startLocationManager()
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startLocationManager() {
        println("startLocationManager")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
            timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("didTimeOut"), userInfo: nil, repeats: false)
            
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            if let timer = timer {
                timer.invalidate()
            }
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func didTimeOut() {
        println("Time out")
        
        if location == nil {
            stopLocationManager()
            
            lastLocationError = NSError(domain: "WorkoutLocationPickErrorDomain", code: 1, userInfo: nil)
        }
    }
    
    func stringForPlacemark(placemark: CLPlacemark) -> String {
        var line1 = ""
        line1.addText(placemark.subLocality)
        line1.addText(placemark.thoroughfare, withSeparator: " ")
        line1.addText(placemark.subThoroughfare, withSeparator: " ")
        
        //var line2 = ""
        //line2.addText(placemark.locality)
        //line2.addText(placemark.administrativeArea, withSeparator: " ")
        return line1
        //return line1.isEmpty ? (line2 + "\n") : (line1 + "\n" + line2)
    }

}

// MARK: - Extension UISearchBarDelegate

extension LocationPickViewController: UISearchBarDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}

// MARK: - Extension CLLocationManagerDelegate

extension LocationPickViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("didFailWithError: \(error)")
        
        if error.code == CLError.LocationUnknown.rawValue {
            return
        }
        lastLocationError = error
        
        stopLocationManager()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let newLocation = locations.last as? CLLocation
        println("didUpdateLocation: \(newLocation)")
        if newLocation?.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        if newLocation?.horizontalAccuracy < 0 {
            return
        }
        
        var distance = CLLocationDistance(DBL_MAX)
        if let location = location {
            distance = newLocation!.distanceFromLocation(location)
        }
        
        if location == nil || location!.horizontalAccuracy > newLocation?.horizontalAccuracy {
            
            lastLocationError = nil
            location = newLocation
            if newLocation?.horizontalAccuracy <= locationManager.desiredAccuracy {
                println("update location done!")
                stopLocationManager()

                println("distance: \(distance)")
                if distance > 0 {
                    performingReverseGeocoding = false
                }
            }
            
            if !performingReverseGeocoding {
                println("start geo coding")
                performingReverseGeocoding = true
                
                geocoder.reverseGeocodeLocation(location, completionHandler: {
                    placemarks, error in
                    println("found placemarks:")
                    for placemark in placemarks {
                        let stringForPlacemark = self.stringForPlacemark(placemark as! CLPlacemark)
                        println("\(stringForPlacemark)\n")
                    }
                    println("error: \(error)")
                    if error == nil && !placemarks.isEmpty {
                        self.placemark = placemarks.last as? CLPlacemark
                    } else {
                        self.placemark = nil
                    }
                    
                    self.performingReverseGeocoding = false
                    
                })
            }

        } else if distance < 1.0 {
            let timeInterval = newLocation?.timestamp.timeIntervalSinceDate(location!.timestamp)
            if timeInterval > 10 {
                println("Force done!")
                stopLocationManager()
            }
        }
    }
}

// MARK: - Extension UISearchBarDelegate

extension LocationPickViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({
            response, error in
            var placemarks = [CLPlacemark]()
            for item in response.mapItems {
                placemarks.append(item.placemark as CLPlacemark!)
            }
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.showAnnotations(placemarks, animated: false)
        })
    }
}

// MARK: - Extension MKMapViewDelegate

extension LocationPickViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        println("mapView:didSelectAnnotationView:")
        showButtons()
        pickedLocation = view.annotation.title!
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        //TODO: customize a annotationView

        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "Location"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as MKAnnotationView!
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.enabled = true
            annotationView.canShowCallout = true
            //annotationView.draggable = true
            
            
            annotationView.image = UIImage(named: "Location Filled")
            
        } else {
            annotationView.annotation = annotation
        }
        return annotationView
    }
}