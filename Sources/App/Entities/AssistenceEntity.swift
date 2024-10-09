//
//  AssistenceEntity.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Fluent
import Foundation

final class AssistenceEntity: Model, @unchecked Sendable {
    
    static let schema = "trips"
    
    @ID
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "fileName")
    var fileName: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "modified_at", on: .update)
    var modifiedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, title: String, createdAt: Date? = nil, modifiedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
    
    convenience init(input: AssistenceModel.Input) {
        self.init(title: "")
    }
}
