//
//  Website+Vapor.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor

extension File {
    
    public var name: String? {
        
        let parts = self.filename.split(separator: ".")
        
        if parts.count > 1 {
            return parts.first.map(String.init)
            
        } else {
            return nil
        }
    }
}
