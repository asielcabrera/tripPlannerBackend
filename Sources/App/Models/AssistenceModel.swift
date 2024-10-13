//
//  AssistenceModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import protocol Vapor.Content

enum AssistenceModel {
    struct Input: Content {
        let firstName: String
        let lastName: String
        
    }
    struct Output: Content {
        
    }
}
