//
//  HeaderView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

struct HeaderView: View {
    var body: Content {
        Section {
            Div {
                A {
                    Span {
                        "Welcome to"
                    }.class("text-xs bg-blue-600 rounded-full text-white px-4 py-1.5 mr-3")
                    Span {
                        "Community Connection Florida Mental Health."
                    }.class("text-sm font-medium")
                    
                    Svg {
                        Path {
                            
                        }
                        .custom(key: "file-rule", value: "evenodd")
                        .custom(key: "clip-rule", value: "evenodd")
                        .draw("M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z")
                        
                    }
                    .class("ml-2 w-5 h-5")
                    .viewBox("0 0 20 20")
                    .namespace("http://www.w3.org/2000/svg")
                    .fill("currentColor")
                    
                }
                .reference("#")
                .class("inline-flex justify-between items-center py-1 px-1 pr-4 mb-7 text-sm text-gray-700 bg-gray-100 rounded-full dark:bg-gray-800 dark:text-white hover:bg-gray-200 dark:hover:bg-gray-700")
                .role(.alert)
                
                H1 {
                    "We invest in the world’s potential"
                }
                .class("mb-4 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white")
                Paragraph {
                    "Our organization is dedicated to serving our patients with the highest level of treatment and support for mental health."
                }
                .class("mb-8 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400")
            }
            .class("py-8 px-4 mx-auto max-w-screen-xl text-center lg:py-16 lg:px-12")
        }
        .class("bg-white dark:bg-gray-900")
    }
}
