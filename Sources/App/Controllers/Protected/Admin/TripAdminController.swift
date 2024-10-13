//
//  TripAdminController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor
import HTMLKitVapor

struct TripAdminController {
    // [/]
    @Sendable
    func listDriver(_ request: Request) async throws -> View {
       
        let page: Int = request.query["page"] ?? 1
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        
        let pagination = try await PassangerRepository(database: request.db)
            .find()
            .map(PassangerModel.Output.init)
            .page(page: page, per: 10)
        
        let user = try request.auth.require(UserModel.Output.self)
        let viewModel = PassangersAdminPageModel.IndexView(user: user, pagination: pagination)
        
        return try await request.htmlkit.render(PassangersAdminPage.IndexView(viewModel: viewModel))
    }
    
    // [/create]
    @Sendable
    func createDriverView(_ request: Request) async throws -> View {
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return try await request.htmlkit.render(PassangersAdminPage.CreateView())
    }
    
    // [/create/:model]
    @Sendable
    func createDriver(_ request: Request) async throws -> Response {
        
        print(request.body)
        
        
        try PassangerModel.Input.validate(content: request)
        
        let model = try request.content.decode(PassangerModel.Input.self)
        
        let passanger = PassangerModel.Input(firstName: model.firstName, lastName: model.lastName, address: model.address, assistence: model.assistence)

        try await PassangerRepository(database: request.db)
            .insert(entity: PassangerEntity(input: passanger))
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/protected/admin/passangers")
    }
    
    
    
    // [/create]
    @Sendable
    func editDriverView(_ request: Request) async throws -> View {
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let entity = try await PassangerRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        let viewModel = PassangersAdminPageModel.EditView(passanger: entity)
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return try await request.htmlkit.render(PassangersAdminPage.EditView(viewModel: viewModel))
    }
    
    // [/create/:model]
    @Sendable
    func editDriver(_ request: Request) async throws -> Response {
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try PassangerModel.Input.validate(content: request)
        
        let model = try request.content.decode(PassangerModel.Input.self)
        
        let userEntity =  PassangerEntity(input: model)
         
        try await PassangerRepository(database: request.db).update(entity: userEntity, on: id)
        
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/protected/admin/passangers")
    }
    
    // [/delete/:model]
    @Sendable
    func deleteDriver(_ request: Request) async throws -> Response {
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try await PassangerRepository(database: request.db).delete(id: id)
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/protected/admin/passangers")
    }
}

extension TripAdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("trips") { routes in
            routes.get("", use: self.listDriver)
            routes.get("create", use: self.createDriverView)
            routes.post("create", use: self.createDriver)
            routes.get("edit", ":id", use: self.editDriverView)
            routes.post("edit", ":id", use: self.editDriver)
            routes.get("delete", ":id", use: self.deleteDriver)
        }
    }
}
