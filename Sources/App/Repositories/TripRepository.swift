//
//  TripRepository.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Fluent
import Foundation

final class TripRepository: Repository {
    /// The database instance used by the repository for e. g. querying
    var database: Database
    
    /// Initializes the repository with the given database
    init(database: Database) {
        self.database = database
    }
    
    func find(id: UUID) async throws -> TripEntity? {
        try await TripEntity.find(id, on: self.database)
    }

    func find() async throws -> [TripEntity] {
        try await TripEntity.query(on: self.database)
            .all()
    }
    func insert(entity: TripEntity) async throws {
        try await entity.save(on: self.database)
    }
    func patch<Field: QueryableProperty>(field: KeyPath<TripEntity, Field>, to value: Field.Value, for id: UUID) async throws where Field.Model == TripEntity {
        try await database.query(TripEntity.self)
            .filter(\.$id == id)
            .set(field, to: value)
            .update()
    }
    
    func update(entity: TripEntity, on id: UUID) async throws {
        try await database.query(TripEntity.self)
            .filter(\.$id == id)
            .set(\.$forDay, to: entity.forDay)
            .set(\.$passangers, to: entity.passangers)
            .set(\.$status, to: entity.status)
            .update()
    }
    func delete(id: UUID) async throws {
        try await database.query(TripEntity.self)
            .filter(\.$id == id)
            .delete()
    }
    
    func count() async throws -> Int {
        
        return try await database.query(TripEntity.self)
            .count()
    }
}
