//
//  UserSessionAuthenticator.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    
    typealias User = UserModel.Output
    
    func authenticate(sessionID: String, for request: Request) async throws {
        
        if let entity = try await UserRepository(database: request.db).find(email: sessionID) {
            
            let user = UserModel.Output(entity: entity)
            
            request.application.htmlkit.environment.upsert(user, for: \UserModel.Output.self)
            
            request.auth.login(user)
        }
    }
}
