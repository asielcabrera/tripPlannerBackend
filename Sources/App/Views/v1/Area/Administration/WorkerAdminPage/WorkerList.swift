//
//  WorkerList.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

struct WorkerList: View {
    
    var drivers: [DriverModel.Output]
    
    var body: Content {
        Card {
            List(direction: .vertical) {
                for driver in drivers {
                    HStack {
                        Text {
                            driver.firstName
                        }
                        .frame(width: .four)
                        .lineLimit(.one)
                        Text {
                            if let role = UserModel.Roles(rawValue: driver.role.description) {
                                role.description
                            }
                        }
                        .frame(width: .two)
                        .lineLimit(.one)
                
                        Dropdown {
                            List(direction: .vertical) {
                                Link(destination: "/area/admin/workers/\(driver.id)/edit") {
                                    Symbol(system: .pencil)
                                    Text {
                                        "Edit"
                                    }
                                }
                            }
                        } label: {
                            Symbol(system: .ellipsis(.horizontal))
                        }
                        .frame(width: .two)
                        .borderShape(.smallrounded)
                    }
                    .padding(insets: .vertical, length: .small)
                }
            }
            .listStyle(.listgroup)
        }
        .borderShape(.smallrounded)
        .margin(insets: .bottom, length: .medium)
    }
}
