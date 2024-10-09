//
//  IndexController.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/6/24.
//
import HTMLKitVapor
import Vapor

struct IndexController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("", use: self.getIndex)
    }
    
    @Sendable
    private func getIndex(_ req: Request) async throws -> View {
        try await req.htmlkit.render(IndexPageV2.IndexView())
    }
}
