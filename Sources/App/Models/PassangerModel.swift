//
//  PassangerModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import Vapor
@preconcurrency import HTMLKitComponents

struct PassangerModel {
    /// The data transfer object for the credential input
    struct Input: Content, Validatable {
        let firstName: String
        let lastName: String
        let address: String
        let assistence: [String]
        
        static func validations(_ validations: inout Validations) {
            validations.add("lastName", as: String.self, is: .alphanumeric)
            validations.add("firstName", as: String.self, is: .alphanumeric)
            validations.add("address", as: String.self, is: .alphanumeric)
 
        }
        
        static let validators = [
            Validator(field: "lastName", rule: .value),
            Validator(field: "firstName", rule: .value),
        ]
    }
    
    /// The data transfer object for the credential entity
    struct Output: Content {
        
        /// The unique identifier of the user
        let id: UUID
        
        /// The first name of the user
        var firstName: String?
        
        /// The last name of the user
        var lastName: String?
       
        var address: String
        
        var assistence: [String]
        /// A representation of the full name with the last name appearing first.
        var fullname: String? {
            
            if let firstName, let lastName {
                return firstName + " " + lastName
            }
            
            return nil
        }
        
        init(id: UUID, firstName: String, lastName: String, address: String, assistence: [String]) {
            
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.address = address
            self.assistence = assistence

        }
        
        init(entity: PassangerEntity) {
            
            self.init(id: entity.id!, firstName: entity.firstName, lastName: entity.lastName, address: entity.address, assistence: entity.assistence)
            
        }
    }
}

