//
//  LocationManager.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import Foundation
import CoreLocation



final class LocationManager {
    var manager: CLLocationManager
    
    init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
    }
    
    func checkLocationAuthorization() {
        if manager.authorizationStatus != .authorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        }
    }
}
