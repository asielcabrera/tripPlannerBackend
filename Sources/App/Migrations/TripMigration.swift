//
//  TripMigration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/11/24.
//

import Fluent

struct TripMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        
        try await database.schema("trips")
            .id()
            .field("forDay", .date, .required)
            .field("passangers", .array(of: .custom(PassangerEntity.self)), .required)
            .field("status", .string, .required)
            .field("created_at", .datetime)
            .field("modified_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        
        try await database.schema("passangers")
            .delete()
    }
}
