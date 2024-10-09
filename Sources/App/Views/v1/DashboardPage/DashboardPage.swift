//
//  DashboardPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

enum DashboardPage {
    struct IndexView: View {
        var viewModel: DashboardAdminPageModel.IndexView
        
        var body: Content {
            AreaViewContainer(identity: viewModel.user) {
                Header {
                    HStack {
                        Text {
                            viewModel.title
                        }
                        .fontSize(.medium)
                        .fontWeight(.medium)
                    }
                }
                Section {
                    Grid(ratio: .third, spacing: .small) {
                        Card {
                        }
                        .borderShape(.smallrounded)
                        Card {
                        }
                        .borderShape(.smallrounded)
                        Card {
                        }
                        .borderShape(.smallrounded)
                    }
                }
                Section {
                }
            }
        }
    }
}
