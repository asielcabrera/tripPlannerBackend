//
//  LoginModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor
@preconcurrency import HTMLKitComponents

struct LoginModel {
    
    struct Input: Content, Validatable {
        
        /// The username for the login
        var email: String
        
        /// The plaintext password for the login
        var password: String
        
        /// A unique token to verify the forms origin
        let nonce: String
        
        static func validations(_ validations: inout Validations) {
            
            validations.add("email", as: String.self, is: .email)
            validations.add("password", as: String.self, is: .count(8...) && .alphanumeric)
        }
        
        static let validators = [
            Validator(field: "email", rule: .email),
            Validator(field: "password", rule: .value)
        ]
        
        /// Sanitize the input before it is processed any further
        mutating func afterDecode() throws {
            
            self.email = email.sanitize()
            self.password = password.sanitize()
        }
    }
}

