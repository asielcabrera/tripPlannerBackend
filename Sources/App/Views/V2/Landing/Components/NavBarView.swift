//
//  NavBarView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

struct NavBarView: View {
    private let routes: [RouteNavBar] = [
        .init(name: "Home", path: "/"),
        .init(name: "About", path: "#aboutus"),
        .init(name: "Services", path: "#"),
        .init(name: "Pricing", path: "#"),
        .init(name: "Contact", path: "#contactus")
    ]
    var body: Content {
        Nav {
            Div {
                A {
                    Image()
                        .source("https://flowbite.com/docs/images/logo.svg")
                        .class("h-8")
                        .alternate("Website Logo")
                    Span {
                        "COMMUNITY CONNECTION"
                    }
                    .class("self-center text-2xl font-semibold whitespace-nowrap dark:text-white")
                }
                .reference("/")
                .class("flex items-center space-x-3 rtl:space-x-reverse")
                
                Button {
                    Span {
                        "Open main menu"
                    }
                    .class("sr-only")
                    
                    Svg {
                        Path {
                            
                        }
                        .stroke("currentColor")
                        .strokeLineCap(.round)
                        .strokeLineJoin(.round)
                        .strokeWidth(2)
                        .draw("M1 1h15M1 7h15M1 13h15")
                        
                    }
                    .class("w-5 h-5")
                    .custom(key: "aria-hidden", value: "true")
                    .viewBox("0 0 17 14")
                    .namespace("http://www.w3.org/2000/svg")
                    .fill("none")
                }
                .type(.button)
                .aria(controls: "navbar-default")
                .custom(key: "data-collapse-toggle", value: "navbar-default")
                .custom(key: "aria-expanded", value: "false")
                .class("inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600")
                
                Div {
                    Ul {
                        for route in routes {
                            Li {
                                A {
                                    "\(route.name)"
                                }
                                .reference("\(route.path)")
                                .class("block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 dark:text-white md:dark:text-blue-500")
                            }
                        }
                    }
                    .class("font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700")
                }
                .class("hidden w-full md:block md:w-auto")
                .id("navbar-default")
            }
            .class("max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4")
        }
        .class("bg-white border-gray-200 dark:bg-gray-900")
    }
}

struct RouteNavBar {
    let name: String
    let path: String
}
