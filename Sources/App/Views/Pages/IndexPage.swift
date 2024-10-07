//
//  IndexPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/6/24.
//

import HTMLKit
import HTMLKitComponents

struct IndexPage: View {
    var body: Content {
        Document(.html5)
        Html {
            Head {
                Title {
                    "Example"
                }
                Link()
                    .relationship(.stylesheet)
                    .reference("/htmlkit/all.css")
                Script {
                }
                .source("/htmlkit/query.js")
            }
            Body {
                Button(role: .submit) {
                    "Submit"
                }
                .buttonStyle(.primary)
                .borderShape(.smallrounded)
                Script {
                }
                .source("/htmlkit/all.js")
            }
        }
    }
}
