//
//  UserAdminController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKitVapor
import Vapor

// [/protected/admin/users]
struct UserAdminController {
    
    // [/]
    @Sendable
    func getIndex(_ request: Request) async throws -> View {
        
        let page: Int = request.query["page"] ?? 1
        
        let pagination = try await UserRepository(database: request.db)
            .find()
            .map(UserModel.Output.init)
            .page(page: page, per: 10)
        
        let viewModel = UserAdminPageModel.IndexView(pagination: pagination)
        
        return try await request.htmlkit.render(UserAdminPage.IndexView(viewModel: viewModel))
    }
    
    // [/create]
    @Sendable
    func getCreate(_ request: Request) async throws -> View {
        
        let viewModel = UserAdminPageModel.CreateView()
        
        return try await request.htmlkit.render(UserAdminPage.CreateView(viewModel: viewModel))
    }
    
    // [/create/:model]
    @Sendable
    func postCreate(_ request: Request) async throws -> Response {
        
        try UserModel.Input.validate(content: request)
        
        let model = try request.content.decode(UserModel.Input.self)
        
        try await UserRepository(database: request.db)
            .insert(entity: UserEntity(input: model))
        
        return request.redirect(to: "/protected/admin/users")
    }
    
    // [/edit/:id]
    @Sendable
    func getEdit(_ request: Request) async throws -> View {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let entity = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        let viewModel = UserAdminPageModel.EditView(user: entity)
        
        return try await request.htmlkit.render(UserAdminPage.EditView(viewModel: viewModel))
    }
    
    // [/:id/edit/:model]
    @Sendable
    func postEdit(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try UserModel.Input.validate(content: request)
        
        let model = try request.content.decode(UserModel.Input.self)
        
        try await UserRepository(database: request.db)
            .update(entity: UserEntity(input: model), on: id)
        
        return request.redirect(to: "/protected/admin/users")
    }
    
    // [/:id/delete]
    @Sendable
    func getDelete(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try await UserRepository(database: request.db)
            .delete(id: id)
        
        return request.redirect(to: "/protected/admin/users")
    }
    
    // MARK: [/:id/deactivate]
    @Sendable
    func getDeactivate(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let user = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        if let credential = user.credential {
            
            try await CredentialRepository(database: request.db)
                .patch(field: \.$status, to: "deactivated", for: credential.requireID())
        }
        
        return request.redirect(to: "/protected/admin/users/\(id)/edit")
    }
    
    // MARK: [/:id/unlock]
    @Sendable
    func getUnlock(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let user = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        if let credential = user.credential {
            
            try await CredentialRepository(database: request.db)
                .patch(field: \.$status, to: "unlocked", for: credential.requireID())
        }
        
        return request.redirect(to: "/protected/admin/users/\(id)/edit")
    }
    
    // MARK: [/:id/reset]
    @Sendable
    func getReset(_ request: Request) async throws -> Response {
        
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let user = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        if let credential = user.credential {
            
            try await CredentialRepository(database: request.db)
                .patch(field: \.$status, to: "reseted", for: credential.requireID())
        }
        
        return request.redirect(to: "/protected/admin/users/\(id)/edit")
    }
}

extension UserAdminController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        routes.group("users") { routes in
            
            routes.get("", use: self.getIndex)
            routes.get("create", use: self.getCreate)
            routes.post("create", use: self.postCreate)
            routes.get(":id", "edit", use: self.getEdit)
            routes.post(":id", "edit", use: self.postEdit)
            routes.get(":id", "delete", use: self.getDelete)
            routes.get(":id", "deactivate", use: self.getDeactivate)
            routes.get(":id", "unlock", use: self.getUnlock)
            routes.get(":id", "reset", use: self.getReset)
        }
    }
}
