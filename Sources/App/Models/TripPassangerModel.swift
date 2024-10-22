//
//  TripPassangerModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/13/24.
//
import Vapor

enum TripPassangerModel {
    struct Input: Content {
        let tripId: UUID
        let passengerId: UUID
    }
    
    struct Output {
        let id: UUID
        let tripId: UUID
        let passengerId: UUID
        
        init(id: UUID, tripId: UUID, passengerId: UUID) {
            self.id = id
            self.tripId = tripId
            self.passengerId = passengerId
        }
        
        init(tripPassenger: TripPassangerEntity) throws {
            self.id = tripPassenger.id ?? UUID()
            self.tripId = try tripPassenger.trip.requireID()
            self.passengerId = try tripPassenger.passanger.requireID()
        }
    }
}
