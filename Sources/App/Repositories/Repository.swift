//
//  Repository.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import struct Foundation.UUID
import protocol Fluent.Database
import Fluent

protocol Repository {
    associatedtype M: Model
    /// The database instance used by the repository for e. g. querying
    var database: Database { get set }
    
    func find(id: UUID) async throws -> M?
//    func find(email: String) async throws -> M?
    func find() async throws -> [M]
    func insert(entity: M) async throws
    func patch<Field: QueryableProperty>(field: KeyPath<M, Field>, to value: Field.Value, for id: UUID) async throws where Field.Model == M
    
    func update(entity: M, on id: UUID) async throws
    
    func delete(id: UUID) async throws
}
