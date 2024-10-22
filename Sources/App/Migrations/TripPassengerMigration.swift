//
//  TripPassengerMigration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/13/24.
//
import Fluent

struct TripPassengerMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("trip_passengers")
            .id()
            .field("trip_id", .uuid, .required, .references("trips", "id", onDelete: .cascade))
            .field("passenger_id", .uuid, .required, .references("passengers", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("trip_passengers").delete()
    }
}
