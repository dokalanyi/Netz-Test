//
//  CustomPIN.swift
//  Test
//
//  Created by Okalany Daniel on 04/07/2017.
//  Copyright © 2017 Netz Inkubator. All rights reserved.
//
import UIKit
import MapKit

class CustomPIN: MKPointAnnotation {
    var pinColor: UIColor
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
}
