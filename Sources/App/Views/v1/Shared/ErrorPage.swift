//
//  ErrorPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

enum ErrorPage {
    
    struct ErrorView: View {
        
        var message: String
        
        var body: Content {
            BaseContaiterView {
                Main {
                    Div {
                        Paragraph {
                            "404"
                        }
                        .class("text-base font-semibold text-indigo-600")
                        H1 {
                            "Page not found"
                        }
                        .class("mt-4 text-3xl font-bold tracking-tight text-gray-900 sm:text-5xl")
                        
                        Paragraph {
                            "Sorry, we couldn’t find the page you’re looking for."
                        }
                        .class("mt-6 text-base leading-7 text-gray-600")
                        
                        Div {
                            A {
                                "Go back home"
                            }
                            .reference("/")
                            .class("rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600")
                            
                            A {
                                "Contact support"
                                
                                Span {
                                    " &rarr;"
                                }
                                .aria(hidden: true)
                            }
                            .reference("#")
                            .class("text-sm font-semibold text-gray-900")
                        }
                        .class("mt-10 flex items-center justify-center gap-x-6")
                    }
                    .class("text-center")
                }
                .class("grid min-h-full place-items-center bg-white px-6 py-24 sm:py-32 lg:px-8")
            }
        }
    }
}
