//
//  Extension.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import Foundation


extension Date {
    func getDateString() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        
        return "\(month)/\(day)/\(year)"
    }
}




extension Double {
    func meterToMiles() -> Double {
        let meters = Measurement(value: self, unit: UnitLength.meters)
        return meters.converted(to: .miles).value
    }
    
    func toString(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}




extension Int {
    func formatTimeString() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        
        if seconds < 0 {
            return "00:00:00"
        } else {
            if hours == 0 {
                return String(format: "%02d:%02d", minutes, seconds)
            } else {
                return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    }
}

