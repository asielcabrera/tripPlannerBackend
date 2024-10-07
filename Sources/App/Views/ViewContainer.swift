//
//  ViewContainer.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

struct ViewContainer: View {
    
    let content: [Content]
    
    init(@ContentBuilder<Content> content: () -> [Content]) {
        self.content = content()
    }

    var body: Content {
        PageContainer {
            Header {
                HStack(spacing: .between) {
                    Link(destination: "/home") {
                        Text {
                            "mattesmohr"
                        }
                        .fontSize(.medium)
                        .foregroundColor(.black)
                    }
                    .frame(width: .minimum)
                    List(direction: .horizontal) {
                        Link(destination: "/home/#about") {
                            Text {
                                "about"
                            }
                        }
                        Link(destination: "/projects") {
                            Text{ "projects" }
                        }
                        Link(destination: "/feed") {
                            Text{"feed"}
                        }
                        Link(destination: "/articles") {
                            Text{ "blog" }
                        }
                        Link(destination: "https://github.com/mattesmohr", target: .blank) {
                            Image(source: "/assets/github.svg")
                        }
                        Link(destination: "https://iosdev.space/@mattesmohr", target: .blank) {
                            Image(source: "/assets/mastodon.svg")
                        }
                        Link(destination: "https://www.linkedin.com/mattesmohr", target: .blank) {
                            Image(source: "/assets/linkedin.svg")
                        }
                    }
//                    .listSpacing(.large)
//                    .frame(width: .minimum)
                }
            }
            Main {
                content
            }
            Footer {
                HStack(spacing: .between) {
                    List(direction: .horizontal) {
                        Link(destination: "/home") {
                            Text {
                                "DE"
                            }
                        }
                        Link(destination: "/home") {
                            Text {
                                "EN"
                            }
                        }
                    }
                    
//                    .listSpacing(.small)
                    List(direction: .horizontal) {
                        Link(destination: "/legal") {
                            Text{ "legal" }
                        }
                        Link(destination: "/privacy") {
                            Text{ "Privacy" }
                        }
                    }
//                    .listSpacing(.small)
                }
            }
        }
    }
}
