//
//  CredentialMigration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Fluent

struct CredentialMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        
        try await database.schema("credentials")
            .id()
            .field("password", .string, .required)
            .field("status", .string, .required)
            .field("attempt", .int, .required)
            .field("user_id", .uuid, .references("users", "id", onDelete: .cascade))
            .field("created_at", .datetime)
            .field("modified_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        
        try await database.schema("credentials")
            .delete()
    }
}
