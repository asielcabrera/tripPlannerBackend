//
//  AreaViewContainer.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

struct AreaViewContainer: View {
    
    let content: [Content]
    
    init(@ContentBuilder<Content> content: () -> [Content]) {
        self.content = content()
    }
    
    @EnvironmentObject(UserModel.Output.self)
    var identity

    var body: Content {
        AreaPageContainer {
            Header {
                HStack {
                    Text {
                        "Admin Panel"
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
                                Link(destination: "/area/login/logout") {
                                    Symbol(system: .trash)
                                    Text {
                                        "Log out"
                                    }
                                }
                            }
                        } label: {
                            Text {
                                identity.fullname
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
                                Link(destination: "/area/admin/home") {
                                    Symbol(system: .house)
                                    "home"
                                }
                                .fontSize(.extralarge)
                                Link(destination: "/area/admin/projects") {
                                    Symbol(system: .folder)
                                    "projects"
                                }
                                Link(destination: "/area/admin/articles") {
                                    Symbol(system: .file)
                                    "articles"
                                }
                                Link(destination: "/area/admin/feed") {
                                    Symbol(system: .scope)
                                   "feed"
                                }
                                Link(destination: "/area/admin/assets") {
                                    Symbol(system: .photo)
                                    "assets"
                                }
                                Link(destination: "/area/admin/reports") {
                                    Symbol(system: .chart(.pie))
                                    "reports"
                                }
                                Link(destination: "/area/admin/users") {
                                    Symbol(system: .person)
                                    "users"
                                }
                            }
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
