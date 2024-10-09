//
//  EnvironmentHelper.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//
import Vapor

final class SessionStorage {
    @MainActor private static var sessions: [String: Session] = [:]
    
    @MainActor static func set(_ req: Request) {
        Self.sessions["\(String(describing: req.session.id))"] = req.session
    }
    
    @MainActor static func get(_ id: String) -> Session? {
        return Self.sessions[id]
    }
    
    @MainActor static func clear() {
        Self.sessions = [:]
    }
}


@propertyWrapper
struct Profile<T: Authenticatable> {
    private var value: T?

    init() {
//        if let request = SessionStorage.get(<#T##String#>) {
//            self.value = request.authenticatedUser as? T
//        }
    }

    var wrappedValue: T? {
        return value
    }
}
