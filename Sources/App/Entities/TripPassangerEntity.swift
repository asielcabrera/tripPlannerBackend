//
//  TripPassangerEntity.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/13/24.
//
import struct Foundation.UUID
import Fluent

final class TripPassangerEntity: Model, @unchecked Sendable {
    static let schema = "trip_passengers"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "trip_id")
    var trip: TripEntity

    @Parent(key: "passenger_id")
    var passanger: PassangerEntity

    init() {}

    init(id: UUID? = nil, tripID: UUID, passangerID: UUID) {
        self.id = id
        self.$trip.id = tripID
        self.$passanger.id = passangerID
    }
    
    convenience init(input: TripPassangerModel.Input) {
        self.init(tripID: input.tripId, passangerID: input.passengerId)
    }
}
