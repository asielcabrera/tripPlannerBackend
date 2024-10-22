//
//  PassangerMigration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import Fluent

struct PassangerMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        
        try await database.schema("passengers")
            .id()
            .field("firsName", .string, .required)
            .field("lastName", .string, .required)
            .field("address", .string, .required)
            .field("assistence", .array(of: .string), .required)
            .field("created_at", .datetime)
            .field("modified_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        
        try await database.schema("passangers")
            .delete()
    }
}
