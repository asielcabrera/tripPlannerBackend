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
        let id: UUID
        var firstName: String
        var lastName: String
        var address: String
        var assistence: [String]
       
        
        var fullname: String {
            return firstName + " " + lastName
        }
        
        init(id: UUID, firstName: String, lastName: String, address: String, assistence: [String]) {
            
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.address = address
            self.assistence = assistence

        }
        
        init(entity: PassangerEntity) throws {
            self.id = try entity.requireID()
            self.firstName = entity.firstName
            self.lastName = entity.lastName
            self.address = entity.address
            self.assistence = entity.assistence
        }
    }
}

