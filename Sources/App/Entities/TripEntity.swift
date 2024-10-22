//
//  TripEntity.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Fluent
import Foundation

final class TripEntity: Model, @unchecked Sendable {
    
    static let schema = "trips"
    
    @ID
    var id: UUID?
    
    @Field(key: "forDay")
    var forDay: String
    
    @Siblings(through: TripPassangerEntity.self, from: \.$trip, to: \.$passanger) // Relación muchos a muchos
    var passengers: [PassangerEntity]
    
    @Field(key: "status")
    var status: TripModel.TripStatus
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "modified_at", on: .update)
    var modifiedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, forDay: Date, status: TripModel.TripStatus, createdAt: Date? = nil, modifiedAt: Date? = nil) {
        self.id = id
        self.forDay = forDay.formatted(date: .medium, time: .none)
        self.status = status
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
    
    convenience init(input: TripModel.Input) {
        self.init(forDay: input.forDay, status: input.status)
    }
}

