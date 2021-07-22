//
//  DateTimeManager.swift
//  WeatherApp
//
//  Created by President Raindas on 22/07/2021.
//

import Foundation

final class DateTimeManager {
    
    let formatter = DateFormatter()
    
    func epochToHumanDate(timestamp: Int) -> Date {
        let epochTime = TimeInterval(timestamp)
        return Date(timeIntervalSince1970: epochTime)
    }
    
    func epochToDay(timestamp: Int) -> String {
        formatter.dateStyle = .full
        // split datetime into two parts
        // expected human date to look like “Tuesday, April 12, 1952 AD” or “3:30:42 PM Pacific Standard Time”
        let humanDateParts = formatter.string(from: epochToHumanDate(timestamp: timestamp)).components(separatedBy: ",")
        return humanDateParts[0]
    }
    
    func epochToDayDate(timestamp: Int) -> String {
        // expected return -> Tuesday, Jul 20
        formatter.dateStyle = .full
        // split datetime into two parts
        // expected human date to look like “Tuesday, April 12, 1952 AD” or “3:30:42 PM Pacific Standard Time”
        let humanDateParts = formatter.string(from: epochToHumanDate(timestamp: timestamp)).components(separatedBy: ",")
        return humanDateParts[0]+","+humanDateParts[1]
    }
}
