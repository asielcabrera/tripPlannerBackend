//
//  AddressModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//
import Vapor

struct AddressModel {
    struct Input: Content {
        let tag: String
        let direction: String
        let passangerId: UUID
    }
    
    struct Output: Content {
        let id: UUID
        let tag: String
        let direction: String
    }
}
