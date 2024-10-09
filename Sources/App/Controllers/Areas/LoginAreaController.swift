//
//  LoginAreaController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKitVapor
import Vapor

// [/area/login]
struct LoginAreaController {
    
    // [/]
    @Sendable
    func getIndex(_ request: Request) async throws -> Response {
        return request.redirect(to: "/area/login/login")
    }
    
    // [/login]
    @Sendable
    func getLogin(_ request: Request) async throws -> View {
        
        // Create form token and store it to verify it in the post request
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        
        let viewModel = LoginAreaPageModel.LoginViewModel()
        
        return try await request.htmlkit.render(LoginAreaPage.LoginView(viewModel: viewModel))
    }
    
    // [/login/:model]
    @Sendable
    func postLogin(_ request: Request) async throws -> Response {
        
        try LoginModel.Input.validate(content: request)
        
        let login = try request.content.decode(LoginModel.Input.self)
        
        guard let nonce = request.application.htmlkit.environment.retrieve(for: \Nonce.self) as? Nonce else {
            throw Abort(.internalServerError)
        }
        
        try nonce.verify(nonce: login.nonce)
        
        guard let user = try await UserRepository(database: request.db)
            .find(email: login.email) else {
            return request.redirect(to: "/area/auth/login")
        }
        
        // Check credential and the current status
        if let credential = user.credential {
            
            switch credential.status {
            case "deactivated", "locked":
                // Do nothing
                break
                
            case "reseted":
                return request.redirect(to: "/area/auth/\(try user.requireID())/reset")
                
            default:
                
                if try await request.password.async.verify(login.password, created: credential.password) {
                    
                    request.session.authenticate(UserModel.Output(entity: user))
                    
                    // The attempt was successful, let's reset the counter
                    if credential.attempt > 0 {
                        // Reset the counter
                        try await CredentialRepository(database: request.db)
                            .patch(field: \.$attempt, to: 0, for: credential.requireID())
                    }
            
                    return request.redirect(to: "/area/admin/dashboard")
                    
                } else {
                    
                    // Track the attempt. If the maximum number of attempts is reached, lock the account
                    if credential.attempt < 4 {
                        // Increment the attempt count
                        try await CredentialRepository(database: request.db)
                            .patch(field: \.$attempt, to: (credential.attempt + 1), for: credential.requireID())
                        
                    } else {
                        // Otherwise lock the account
                        try await CredentialRepository(database: request.db)
                            .patch(field: \.$status, to: "locked", for: credential.requireID())
                    }
                }
            }
            
        } else {
            return request.redirect(to: "/area/auth/\(try user.requireID())/register")
        }
        
        return request.redirect(to: "/area/auth/login")
    }
    
    // [/logout]
    @Sendable
    func getLogout(_ request: Request) async throws -> Response {
        
        request.auth.logout(UserModel.Output.self)
        request.session.unauthenticate(UserModel.Output.self)
        
        return request.redirect(to: "/area/auth/login")
    }
    
    // [:id/register]
    @Sendable
    func getRegister(_ request: Request) async throws -> View {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let user = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        if let _ = user.credential {
            // The user is already registered, therefore abort the request
            throw Abort(.badRequest)
        }
        
        // Create form token and store it to verify it in the post request
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        
        return try await request.htmlkit.render(LoginAreaPage.RegisterView())
    }
    
    // [:id/register/:model]
    @Sendable
    func postRegister(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try ResetModel.Input.validate(content: request)
        
        let reset = try request.content.decode(ResetModel.Input.self)
        
        guard let nonce = request.application.htmlkit.environment.retrieve(for: \Nonce.self) as? Nonce else {
            throw Abort(.internalServerError)
        }
        
        try nonce.verify(nonce: reset.nonce)
        
        let digest = try await request.password.async.hash(reset.password)
        
        try await CredentialRepository(database: request.db)
            .insert(entity: CredentialEntity(password: digest, status: "unlocked", attempt: 0, userId: id))
        
        return request.redirect(to: "/area/auth/login")
    }
    
    // [:id/reset]
    @Sendable
    func getReset(_ request: Request) async throws -> View {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let user = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        if let credential = user.credential {
            
            if credential.status != "reseted" {
                // The reset was not initiated, therefore abort the request
                throw Abort(.badRequest)
            }
        }
        
        // Create form token and store it to verify it in the post request
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        
        return try await request.htmlkit.render(LoginAreaPage.ResetView())
    }
    
    // [:id/reset/:model]
    @Sendable
    func postReset(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try ResetModel.Input.validate(content: request)
        
        let reset = try request.content.decode(ResetModel.Input.self)
        
        guard let nonce = request.application.htmlkit.environment.retrieve(for: \Nonce.self) as? Nonce else {
            throw Abort(.internalServerError)
        }
        
        try nonce.verify(nonce: reset.nonce)
        
        guard let user = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        if let credential = user.credential {
            
            credential.password = try await request.password.async.hash(reset.password)
            credential.status = "unlocked"
            
            try await CredentialRepository(database: request.db)
                .update(entity: credential, on: credential.requireID())
        }
        
        return request.redirect(to: "/area/auth/login")
    }
}

extension LoginAreaController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        routes.group("auth") { routes in
            
            routes.get("", use: self.getIndex)
            routes.get("login", use: self.getLogin)
            routes.post("login", use: self.postLogin)
            routes.get("logout", use: self.getLogout)
            routes.get(":id", "register", use: self.getRegister)
            routes.post(":id", "register", use: self.postRegister)
            routes.get(":id", "reset", use: self.getReset)
            routes.post(":id", "reset", use: self.postReset)
        }
    }
}