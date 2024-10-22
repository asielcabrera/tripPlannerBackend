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
    
    var week: Int {
        let calendar = Calendar.current
        return calendar.component(.weekOfYear, from: self)
    }
    
    var weekDay: String {
        let calendar = Calendar.current
        return calendar.weekdaySymbols[calendar.component(.weekday, from: self) - 1]
    }
    
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    static func getWeekDay(forWeek weekNumber: Int, year: Int) -> [String] {
        var calendar = Calendar(identifier: .gregorian)
            calendar.firstWeekday = 2 // Establecer el primer día de la semana en lunes

        var dates: [String] = []
            
            // Comenzar desde el primer día del año
            guard let firstOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1)) else {
                return []
            }
            
            // Encontrar el primer día de la semana correspondiente al número de semana
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: firstOfYear)
            
            guard let weekStartDate = weekInterval?.start else {
                return []
            }
            
            // Calcular el inicio de la semana correspondiente al número de semana
            guard let startOfWeek = calendar.date(byAdding: .weekOfYear, value: weekNumber - 1, to: weekStartDate) else {
                return []
            }
            
            // Obtener los días de lunes a jueves
            for day in 0..<7 {
                if let dayDate = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                    dates.append(dayDate.formatted(date: .medium, time: .none))
                }
            }
            
            return dates
    }
}
