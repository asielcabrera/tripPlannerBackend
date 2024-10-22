//
//  DriverAdminController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import Vapor
import HTMLKitVapor

struct DriverAdminController {
    
    // [/]
    @Sendable
    func listDriver(_ request: Request) async throws -> View {
       
        let page: Int = request.query["page"] ?? 1
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        
        let pagination = try await UserRepository(database: request.db)
            .find()
            .map(UserModel.Output.init)
            .page(page: page, per: 10)
        
        let user = try request.auth.require(UserModel.Output.self)
        let viewModel = DriverAdminPageModel.IndexView(user: user, pagination: pagination)
        
        return try await request.htmlkit.render(DriversAdminPage.IndexView(viewModel: viewModel))
    }
    
    // [/create]
    @Sendable
    func createDriverView(_ request: Request) async throws -> View {
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return try await request.htmlkit.render(DriversAdminPage.CreateView())
    }
    
    // [/create/:model]
    @Sendable
    func createDriver(_ request: Request) async throws -> Response {
        
        print(request.body)
        
        
        try DriverModel.Input.validate(content: request)
        
        let model = try request.content.decode(DriverModel.Input.self)
        
        let user = UserModel.Input(email: model.email, firstName: model.firstName, lastName: model.lastName ,role: model.role)

        try await UserRepository(database: request.db)
            .insert(entity: UserEntity(input: user))
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/protected/admin/workers")
    }
    
    
    
    // [/create]
    @Sendable
    func editDriverView(_ request: Request) async throws -> View {
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let entity = try await UserRepository(database: request.db)
            .find(id: id) else {
            throw Abort(.notFound)
        }
        
        let viewModel = UserAdminPageModel.EditView(user: entity)
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return try await request.htmlkit.render(DriversAdminPage.EditView(viewModel: viewModel))
    }
    
    // [/create/:model]
    @Sendable
    func editDriver(_ request: Request) async throws -> Response {
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try DriverModel.Input.validate(content: request)
        
        let model = try request.content.decode(UserModel.Input.self)
        
        let userEntity =  UserEntity(input: model)
         
        try await UserRepository(database: request.db).update(entity: userEntity, on: id)
        
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/protected/admin/workers")
    }
    
    // [/delete/:model]
    @Sendable
    func deleteDriver(_ request: Request) async throws -> Response {
        guard let id = request.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        try await UserRepository(database: request.db).delete(id: id)
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/protected/admin/workers")
    }
}

extension DriverAdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("workers") { routes in
            routes.get("", use: self.listDriver)
            routes.get("create", use: self.createDriverView)
            routes.post("create", use: self.createDriver)
            routes.get("edit", ":id", use: self.editDriverView)
            routes.post("edit", ":id", use: self.editDriver)
            routes.get("delete", ":id", use: self.deleteDriver)
        }
    }
}
