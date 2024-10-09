//
//  DriverAdminController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import Vapor
import HTMLKitVapor

struct DriverAdminController {
    @Sendable
    func listDriver(_ request: Request) async throws -> View {
       
        let page: Int = request.query["page"] ?? 1
        
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        
        let pagination = try await UserRepository(database: request.db)
            .find(role: .driver)
            .map(DriverModel.Output.init)
            .page(page: page, per: 10)
        
        let user = try request.auth.require(UserModel.Output.self)
        let viewModel = WorkerAdminPageModel.IndexView(user: user, pagination: pagination)
        return try await request.htmlkit.render(WorkerAdminPage.IndexView(viewModel: viewModel))
    }
    
    @Sendable
    func createDriverView(_ request: Request) async throws -> View {
        let viewModel = WorkerAdminPageModel.CreateView()
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return try await request.htmlkit.render(WorkerAdminPage.CreateView(viewModel: viewModel))
    }
    
    // [/create/:model]
    @Sendable
    func createDriver(_ request: Request) async throws -> Response {
        try DriverModel.Input.validate(content: request)
        
        let model = try request.content.decode(DriverModel.Input.self)
        
        let user = UserModel.Input(email: model.username, firstName: model.firstName, lastName: model.lastName ,role: model.role)
        
        try await UserRepository(database: request.db)
            .insert(entity: UserEntity(input: user))
        request.application.htmlkit.environment.upsert(Nonce(), for: \Nonce.self)
        return request.redirect(to: "/area/admin/workers")
    }
}

extension DriverAdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("workers") { routes in
            routes.get("", use: self.listDriver)
            routes.get("create", use: self.createDriverView)
            routes.post("create", use: self.createDriver)
        }
    }
}
