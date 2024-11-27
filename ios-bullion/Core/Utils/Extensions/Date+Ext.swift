//
//  Date+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation

extension Date {
    func toFormattedString(format: String = "dd MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
}
