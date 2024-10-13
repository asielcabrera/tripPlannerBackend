//
//  AssistenceAdminController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKitVapor
import Vapor

struct AssistenceAdminController {
    // [/]
    @Sendable
    func getIndex(_ request: Request) async throws -> View {
//        let user: UserModel.Output = try request.auth.require()
        return try await request.htmlkit.render(AssistenceAdminPage.IndexView())
    }
}

extension AssistenceAdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("assistence") { routes in
            routes.get("", use: self.getIndex)
        }
    }
}
