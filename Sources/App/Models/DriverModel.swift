//
//  DriverModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor
@preconcurrency import HTMLKitComponents

struct DriverModel {
    /// The data transfer object for the credential input
    struct Input: Content, Validatable {
        let firstName: String
        let lastName: String
        let username: String
        let password: String
        let role: String
        
        static func validations(_ validations: inout Validations) {
            
            validations.add("username", as: String.self, is: .email)
            validations.add("lastName", as: String.self, is: .alphanumeric)
            validations.add("firstName", as: String.self, is: .alphanumeric)
            validations.add("role", as: String.self, is: .alphanumeric)
            validations.add("password", as: String.self, is: .count(8...) && .alphanumeric)
        }
        
        static let validators = [
            Validator(field: "username", rule: .email),
            Validator(field: "password", rule: .value),
            Validator(field: "lastName", rule: .value),
            Validator(field: "firstName", rule: .value),
            Validator(field: "role", rule: .value),
        ]
    }
    
    /// The data transfer object for the credential entity
    struct Output: Content {
        
        /// The unique identifier of the user
        let id: UUID
        
        /// The file name of the avatar
        var avatar: AssetModel.Output?
        
        /// The email address of the user
        let email: String
        
        /// The first name of the user
        var firstName: String?
        
        /// The last name of the user
        var lastName: String?
       
        /// The permission role of the user
        let role: String

        /// A representation of the full name with the last name appearing first.
        var fullname: String? {
            
            if let firstName, let lastName {
                return firstName + " " + lastName
            }
            
            return nil
        }
        
        init(id: UUID, avatar: AssetModel.Output? = nil, email: String, firstName: String? = nil, lastName: String? = nil,role: String) {
            
            self.id = id
            self.avatar = avatar
            self.email = email
            self.firstName = firstName
            self.lastName = lastName
            self.role = role
        }
        
        init(entity: UserEntity) {
            
            self.init(id: entity.id!, email: entity.email, firstName: entity.firstName, lastName: entity.lastName, role: entity.role)
            
            if let avatar = entity.avatar {
                self.avatar = AssetModel.Output(entity: avatar)
            }
        }
    }
}

