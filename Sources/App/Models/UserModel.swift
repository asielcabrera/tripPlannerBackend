//
//  UserModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor
@preconcurrency import HTMLKitComponents

struct UserModel {
    
    enum Roles: String, Codable, CaseIterable {
        
        case administrator
        case moderator
        case customer
        case driver
        
        var description: String {
            
            switch rawValue {
            case "administrator":
                return "Administrator"
                
            case "moderator":
                return "Moderator"
                
            case "customer":
                return "Customer"
                
            case "driver":
                return "Driver"
                
            default:
                return "Unkown"
            }
        }
    }
    
    /// The data transfer object for the user input
    struct Input: Content, Validatable {
        
        /// The identifier of the user avatar
        var avatarId: String?
        
        /// The email for the user
        var email: String
        
        /// The first name for the user
        var firstName: String?
        
        /// The last name for the user
        var lastName: String?
        
        /// A textual description of the user
        var biography: String?
        
        /// A permission role for the user
        let role: String
        
        init(avatarId: String? = nil, email: String, firstName: String? = nil, lastName: String? = nil, biography: String? = nil, role: String) {
            self.avatarId = avatarId
            self.email = email
            self.firstName = firstName
            self.lastName = lastName
            self.biography = biography
            self.role = role
        }
        
        static func validations(_ validations: inout Validations) {
            
            validations.add("email", as: String.self, is: !.empty)
            validations.add("firstName", as: String.self, is: !.empty)
            validations.add("lastName", as: String.self, is: !.empty)
        }
        
        static let validators = [
            Validator(field: "email", rule: .email),
            Validator(field: "firstName", rule: .value),
            Validator(field: "lastName", rule: .value)
        ]
        
        /// Sanitize the input before it is processed any further
        mutating func afterDecode() throws {
            
            self.email = email.sanitize()
            self.firstName = firstName?.sanitize()
            self.lastName = lastName?.sanitize()
            self.biography = biography?.sanitize()
        }
    }
    
    /// The data transfer object for the user entity
    struct Output: Content, SessionAuthenticatable {
        
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
        
        /// A textual description of the user
        var biography: String?
        
        /// The permission role of the user
        let role: String
        
        /// The credential related the user
        var credential: CredentialModel.Output?
        
        /// The timestamp when the user was first stored
        let createdAt: Date
        
        /// The timestamp when the user was last updated
        let modifiedAt: Date
        
        /// The identifier for the user session
        var sessionID: String {
            self.email
        }
        
        /// A representation of the full name with the last name appearing first.
        var fullname: String? {
            
            if let firstName, let lastName {
                return firstName + " " + lastName
            }
            
            return nil
        }
        
        init(id: UUID, avatar: AssetModel.Output? = nil, email: String, firstName: String? = nil, lastName: String? = nil, biography: String? = nil, role: String, credential: CredentialModel.Output? = nil, createdAt: Date, modifiedAt: Date) {
            
            self.id = id
            self.avatar = avatar
            self.email = email
            self.firstName = firstName
            self.lastName = lastName
            self.biography = biography
            self.role = role
            self.credential = credential
            self.createdAt = createdAt
            self.modifiedAt = modifiedAt
        }
        
        init(entity: UserEntity) {
            
            self.init(id: entity.id!, email: entity.email, firstName: entity.firstName, lastName: entity.lastName, biography: entity.biography, role: entity.role, createdAt: entity.createdAt!, modifiedAt: entity.modifiedAt!)
            
            if let avatar = entity.avatar {
                self.avatar = AssetModel.Output(entity: avatar)
            }
            
            if let credential = entity.credential {
                self.credential = CredentialModel.Output(entity: credential)
            }
        }
    }
}
