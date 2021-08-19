//
//  Location.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import Foundation
import RealmSwift

final class Location: Object {
    @objc dynamic public private(set) var latitude = 0.0
    @objc dynamic public private(set) var longitude = 0.0
    
    convenience init(lat: Double, long: Double) {
        self.init()
        self.latitude = lat
        self.longitude = long
    }
}

