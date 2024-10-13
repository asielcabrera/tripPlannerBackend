//
//  PassangerRepository.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import Fluent
import Foundation

final class PassangerRepository: Repository {
    /// The database instance used by the repository for e. g. querying
    var database: Database
    
    /// Initializes the repository with the given database
    init(database: Database) {
        self.database = database
    }
    
    func find(id: UUID) async throws -> PassangerEntity? {
        try await PassangerEntity.find(id, on: self.database)
    }

    func find() async throws -> [PassangerEntity] {
        try await PassangerEntity.query(on: self.database)
            .all()
    }
    func insert(entity: PassangerEntity) async throws {
        try await entity.save(on: self.database)
    }
    func patch<Field: QueryableProperty>(field: KeyPath<PassangerEntity, Field>, to value: Field.Value, for id: UUID) async throws where Field.Model == PassangerEntity {
        try await database.query(PassangerEntity.self)
            .filter(\.$id == id)
            .set(field, to: value)
            .update()
    }
    
    func update(entity: PassangerEntity, on id: UUID) async throws {
        try await database.query(PassangerEntity.self)
            .filter(\.$id == id)
            .set(\.$firstName, to: entity.firstName)
            .set(\.$lastName, to: entity.lastName)
            .set(\.$address, to: entity.address)
            .set(\.$assistence, to: entity.assistence)
            .update()
    }
    func delete(id: UUID) async throws {
        try await database.query(PassangerEntity.self)
            .filter(\.$id == id)
            .delete()
    }
    
    func count() async throws -> Int {
        
        return try await database.query(PassangerEntity.self)
            .count()
    }
}
