//
//  BaseContaiterView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

struct BaseContaiterView: View {
    
    var content: [BodyElement]
    
    
    init(@ContentBuilder<BodyElement> content: () -> [BodyElement]) {
        self.content = content()
    }
    
    var body: Content {
        Document(.html5)
        Html {
            Head {
                Title { "Trip Planner" }
                
                Link()
                    .relationship(.stylesheet)
                    .reference("https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
                
                Link()
                    .relationship(.stylesheet)
                    .reference("https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.css")
            }
            
            Body {
                content
                Script {}.source("https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.js")
            }
        }
    }
}
