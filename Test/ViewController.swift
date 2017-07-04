//
//  ViewController.swift
//  Test
//
//  Created by Okalany Daniel on 04/07/2017.
//  Copyright © 2017 Netz Inkubator. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let locationPin = CustomPIN(pinColor: UIColor.green)
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        locationManager.startUpdatingLocation()
        
        let longPress = UITapGestureRecognizer(target: self, action: #selector(ViewController.mapTapped(_:))) // colon needs to pass through info
        map.addGestureRecognizer(longPress)

    }

    func mapTapped(_ recognizer: UIGestureRecognizer) {
        let touchedAt = recognizer.location(in: self.map)
        let touchedAtCoordinate : CLLocationCoordinate2D = map.convert(touchedAt, toCoordinateFrom: self.map)
        
        let newPin = CustomPIN(pinColor: UIColor.red)
        newPin.coordinate = touchedAtCoordinate
        
        map.addAnnotation(newPin)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        map.removeAnnotation(locationPin)
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        map.setRegion(region, animated: true)
        locationPin.coordinate = location.coordinate
        
        map.addAnnotation(locationPin)
        locationManager.stopUpdatingLocation()
    }
    
    func drawLine(pointA: MKPointAnnotation, pointB: MKPointAnnotation){
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView { // 2
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            
            let colorPointAnnotation = annotation as! CustomPIN
            view.pinTintColor = colorPointAnnotation.pinColor
        }
        
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
