//
//  AreaViewContainer.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

struct AreaViewContainer: View {
    
    let identity: UserModel.Output?
    let content: [Content]
    
    init(identity: UserModel.Output? = nil, @ContentBuilder<Content> content: () -> [Content]) {
        self.identity = identity
        self.content = content()
    }
   

    var body: Content {
        AreaPageContainer {
            Header {
                HStack {
                    Text {
                        "Travel Admin Panel"
                    }
                    .fontSize(.medium)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    
                    HStack(spacing: .medium) {
                        Dropdown {
                            List(direction: .vertical) {
                                Text {
                                    "No notifications yet."
                                }
                            }
                            .listStyle(.listgroup)
                        } label: {
                            Symbol(system: .bell)
                        }
                        .borderShape(.smallrounded)
                        Dropdown {
                            List(direction: .vertical) {
                                Link(destination: "/area/auth/logout") {
                                    Symbol(system: .trash)
                                    Text {
                                        "Log out"
                                    }
                                }
                            }
                        } label: {
                            Text {
                                identity?.fullname ?? "Full Name"
                            }
                        }
                        .borderShape(.smallrounded)
                    }
                    .frame(width: .minimum)
                    .margin(insets: .leading, length: .auto)
                }
            }
            Main {
                Aside {
                    Section {
                        Navigation {
                            List(direction: .vertical) {
                                Link(destination: "/area/admin/dashboard") {
                                    Symbol(system: .house)
                                    Text { "Dashboard" }
                                }
                                .fontSize(.extralarge)
                               
                                Link(destination: "/area/admin/workers/") {
                                    Symbol(system: .person)
                                    Text { "Workers" }
                                }
                                
                                Link(destination: "/area/admin/passangers") {
                                    Symbol(system: .file)
                                    Text { "Passangers" }
                                }
                                
                                Link(destination: "/area/admin/trips") {
                                    Symbol(system: .scope)
                                    Text { "Trips" }
                                }
                                
                                Link(destination: "/area/admin/assistence") {
                                    Symbol(system: .photo)
                                    Text { "Assistence" }
                                }
                            }
                            .listSpacing(.small)
                        }
                        .navigationStyle(.menu)
                    }
                    Footer {
                        
                    }
                }
                
                Section {
                    content
                }
            }
        }
    }
}
