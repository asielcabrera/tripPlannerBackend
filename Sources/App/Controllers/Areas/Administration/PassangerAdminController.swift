//
//  PassangerAdminController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Vapor
import HTMLKitVapor

struct PassangerAdminController {
    // [/]
    @Sendable
    func getIndex(_ request: Request) async throws -> View {
        let user: UserModel.Output = try request.auth.require()
        let viewModel = DashboardAdminPageModel.IndexView(user: user)
        return try await request.htmlkit.render(PassangerAdminPage.IndexView())
    }
}

extension PassangerAdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("passangers") { routes in
            routes.get("", use: self.getIndex)
        }
    }
}
