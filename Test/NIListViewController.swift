//
//  NIListViewController.swift
//  Test
//
//  Created by Okalany Daniel on 04/07/2017.
//  Copyright © 2017 Netz Inkubator. All rights reserved.
//

import UIKit
import MapKit

class NIListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var pins = Array<CustomPIN>()
    var locationPin = CustomPIN(pinColor: UIColor.green)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pins.count
    }
    
    func calculateDistance(pointA: MKPointAnnotation, pointB: MKPointAnnotation) -> Double {
        let a = CLLocation(latitude: pointA.coordinate.latitude, longitude: pointA.coordinate.longitude)
        let b = CLLocation(latitude: pointB.coordinate.latitude, longitude: pointB.coordinate.longitude)
        return a.distance(from: b)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)

        let pin: CustomPIN = self.pins[indexPath.row]
        let title = cell.viewWithTag(1) as! UILabel
        title.text = NSString(format: "Latitude %f, Longitude: %f Distance: %.2f", pin.coordinate.latitude, pin.coordinate.longitude, self.calculateDistance(pointA: pin, pointB: self.locationPin)) as String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
