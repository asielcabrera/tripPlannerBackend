//
//  Website+String.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

extension String {
    func sanitize() -> Self {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
