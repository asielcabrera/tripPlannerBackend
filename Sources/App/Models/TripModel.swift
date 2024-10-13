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
        let passangers: [PassangerModel.Input]
        
    }
    
    struct Output: Content {
        let id: UUID
        var forDay: Date
        var status: TripStatus
        var passangers: [PassangerModel.Output]?
        
        init(id: UUID, forDay: Date, status: TripStatus, passangers: [PassangerModel.Output]? = nil) {
            self.id = id
            self.forDay = forDay
            self.status = status
            self.passangers = passangers
        }
        
        init(tripEntity: TripEntity) throws {
            
            self.init(id: try tripEntity.requireID(), forDay: tripEntity.forDay!, status: tripEntity.status)
      
            if let passangerEntities = tripEntity.passangers {
                self.passangers = passangerEntities.map({ passangerEntity in
                    return PassangerModel.Output(entity: passangerEntity)
                })
            }
        }
    }
}
