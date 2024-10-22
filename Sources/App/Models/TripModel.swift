//
//  TripModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import Vapor

enum TripModel {
    enum TripStatus: String, CaseIterable, Content {
        case created
        case pending
        case running
        case completed
    }
    
    struct Input: Content {
        let forDay: Date
        let status: TripStatus
        let passangers: [PassangerModel.Input]?
    }
    
    struct Output: Content, Equatable {
        static func == (lhs: TripModel.Output, rhs: TripModel.Output) -> Bool {
            lhs.id == rhs.id
        }
        
        let id: UUID
        var forDay: Date
        var status: TripStatus
        var passangers: [PassangerModel.Output]
        
        init(id: UUID, forDay: Date, status: TripStatus, passangers: [PassangerModel.Output]) {
            self.id = id
            self.forDay = forDay
            self.status = status
            self.passangers = passangers
        }
        
        init(tripEntity: TripEntity) throws {
            self.id = try tripEntity.requireID()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.forDay = dateFormatter.date(from: tripEntity.forDay) ?? .now
            self.status = tripEntity.status
            
            self.passangers = try tripEntity.passengers.map { try PassangerModel.Output(entity: $0)}
        }
    }
}
