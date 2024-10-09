//
//  Nonce.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Foundation
import Vapor

/// A unique token to verify its form origin
struct Nonce {
    
    /// The token value
    let value: String
    
    /// Initializes the nonce
    init() {
        self.value = [UInt8].random(count: 32).base64
    }
    
    /// Verifies the form token with the global token
    func verify(nonce: String) throws {
        
        if self.value != nonce {
            throw Abort(.badRequest)
        }
    }
}
