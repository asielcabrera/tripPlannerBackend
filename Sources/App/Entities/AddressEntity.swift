//
//  AddressEntity.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import Fluent
import Foundation

final class AddressEntity: Model, @unchecked Sendable {
    
    static let schema = "address"
    
    @ID
    var id: UUID?
    
    @Field(key: "tag")
    var tag: String
    
    @Field(key: "direction")
    var direction: String
    
    @Parent(key: "passanger_id")
    var passanger: PassangerEntity
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "modified_at", on: .update)
    var modifiedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, tag: String, direction: String, passangerId: UUID, createdAt: Date? = nil, modifiedAt: Date? = nil) {
        self.id = id
        self.tag = tag
        self.direction = direction
        self.$passanger.id = passangerId
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
    
    convenience init(input: AddressModel.Input) {
        self.init(tag: input.tag, direction: input.direction, passangerId: input.passangerId)
    }
}
