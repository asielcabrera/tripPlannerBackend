//
//  TripAdminPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import HTMLKit
import HTMLKitComponents

enum TripAdminPage {
    struct IndexView: View {
        var body: Content {
            AreaViewContainer {
                Header {
                    HStack {
                        Text { "Trip Admin Page" }
                        .fontSize(.medium)
                        .fontWeight(.medium)
                    }
                }
                Section {
                    VStack {
                        
                    }
                }
            }
        }
    }
}
