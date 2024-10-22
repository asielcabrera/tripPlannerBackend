//
//  TripSampleDataMigration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/13/24.
//

import Fluent

struct TripSampleDataMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        
        // Crear datos de prueba para pasajeros
        let passenger1 = PassangerEntity(firstName: "John", lastName: "Doe", address: "", assistence: [])
        let passenger2 = PassangerEntity(firstName: "Jane", lastName: "Smith", address: "", assistence: [])
        let passenger3 = PassangerEntity(firstName: "Alice", lastName: "Johnson", address: "", assistence: [])
        
        
        // Guardar pasajeros en la base de datos
        try await passenger1.save(on: database)
        try await passenger2.save(on: database)
        try await passenger3.save(on: database)
        
        
        
        // Crear un viaje
        let trip1 = TripEntity(forDay: .now.addingTimeInterval(86400), status: .created)
        try await trip1.save(on: database)
        
        // Asociar pasajeros al viaje
        try await trip1.$passengers.attach(passenger1, on: database)
        try await trip1.$passengers.attach(passenger2, on: database)
        try await trip1.save(on: database)
        
        // Crear un viaje
        let trip2 = TripEntity(forDay: .now.addingTimeInterval(86400 * 2), status: .created)
        try await trip2.save(on: database)
        
        // Asociar pasajeros al viaje
        try await trip2.$passengers.attach(passenger1, on: database)
        try await trip2.$passengers.attach(passenger3, on: database)
        try await trip2.save(on: database)
        
        // Crear un viaje
        let trip3 = TripEntity(forDay: .now.addingTimeInterval(86400 * 3), status: .created)
        try await trip3.save(on: database)
        
        // Asociar pasajeros al viaje
        try await trip3.$passengers.attach(passenger2, on: database)
        try await trip3.$passengers.attach(passenger3, on: database)
        try await trip3.save(on: database)
        
        // Crear un viaje
        let trip4 = TripEntity(forDay: .now.addingTimeInterval(86400 * 4), status: .created)
        try await trip4.save(on: database)
        
        // Asociar pasajeros al viaje
        try await trip4.$passengers.attach(passenger1, on: database)
        try await trip4.$passengers.attach(passenger2, on: database)
        try await trip4.$passengers.attach(passenger3, on: database)
        try await trip4.save(on: database)
        
        
        
        
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("passengers").delete()
        try await database.schema("trips").delete()
        try await database.schema("trip_passengers").delete()
    }
}
