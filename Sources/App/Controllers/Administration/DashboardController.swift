//
//  DashboardController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import Vapor
import HTMLKitVapor

struct DashboardController {
    // [/]
    @Sendable
    func getIndex(_ request: Request) async throws -> View {
        return try await request.htmlkit.render(DashboardPage.IndexView())
    }
}

extension DashboardController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("dashboard") { routes in
            routes.get("", use: self.getIndex)
        }
    }
}
