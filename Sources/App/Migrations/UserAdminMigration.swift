//
//  UserAdminMigration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Fluent

struct UserAdminMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        
        let userEntity = UserEntity(email: "admin@admin.com", firstName: "Admin", role: "Administrator")
        
        try await UserRepository(database: database)
            .insert(entity: userEntity)
        
    }
    
    func revert(on database: Database) async throws {
        
        try await database.schema("users")
            .delete()
    }
}
