//
//  Website+Date.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Foundation

extension Date {
    
    func formatted(date: DateFormatter.Style, time: DateFormatter.Style) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = date
        formatter.timeStyle = time
        
        return formatter.string(from: self)
    }
}
