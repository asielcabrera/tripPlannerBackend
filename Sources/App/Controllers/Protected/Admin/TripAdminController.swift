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
    func getIndex(_ request: Request) async throws -> View {
        let user: UserModel.Output = try request.auth.require()
        return try await request.htmlkit.render(TripAdminPage.IndexView())
    }
}

extension TripAdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("trips") { routes in
            routes.get("", use: self.getIndex)
        }
    }
}
