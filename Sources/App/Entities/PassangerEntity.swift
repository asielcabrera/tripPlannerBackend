//
//  PassangerEntity.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import Fluent
import Foundation

final class PassangerEntity: Model, @unchecked Sendable {
    
    static let schema = "passangers"
    
    @ID
    var id: UUID?
    
    @Field(key: "firsName")
    var firstName: String
    
    @Field(key: "lastName")
    var lastName: String
    
    @Field(key: "address")
    var address: String
    
    @Field(key: "assistence")
    var assistence: [String]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "modified_at", on: .update)
    var modifiedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, firstName: String, lastName: String, address: String, assistence: [String], createdAt: Date? = nil, modifiedAt: Date? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.assistence = assistence
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
    
    convenience init(input: PassangerModel.Input) {
        self.init(firstName: input.firstName, lastName: input.lastName, address: input.address, assistence: input.assistence)
    }
}
