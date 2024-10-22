//
//  DashboardAdminPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/9/24.
//

import HTMLKit

enum DashboardAdminPage {
    struct BaseDashboardAdminPage: View {
        let button: String?
        var content: [BodyElement]
        
        
        init(_ button: String? = nil, @ContentBuilder<BodyElement> content: () -> [BodyElement]) {
            self.button = button
            self.content = content()
        }
        
        var body: Content {
            BaseContaiterView {
                Div {
                    
                    DashboardAdminPage.NavbarView(button: button)
                    DashboardAdminPage.SideBarView()
                    
                    Main {
                        Div {
                            content
                        }
                        .class("grid grid-cols-1 sm:grid-cols-1 lg:grid-cols-1 gap-4 mb-1")
                    }
                    .class("p-4 md:ml-64 h-auto pt-20")
                }
                .class("antialiased bg-gray-50 dark:bg-gray-900")
            }
        }
    }
    
    struct IndexView: View {
        var body: Content {
            BaseDashboardAdminPage {
                
            }
        }
    }
        
    struct NavbarView: View {
        
        let button: String?
        
        var body: Content {
            Nav {
                Div {
                    Div {
                        Button {
                            Svg {
                                Path {}
                                    .custom(key: "fill-rule", value: "evenodd")
                                    .custom(key: "clip-rule", value: "evenodd")
                                    .draw("M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z")
                            }
                            .custom(key: "aria-hidden", value: true)
                            .class("w-6 h-6")
                            .fill("currentColor")
                            .viewBox("0 0 20 20")
                            .namespace("http://www.w3.org/2000/svg")
                        
                            Svg {
                                Path {}
                                    .custom(key: "fill-rule", value: "evenodd")
                                    .custom(key: "clip-rule", value: "evenodd")
                                    .draw("M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z")
                            }
                            .custom(key: "aria-hidden", value: true)
                            .class("hidden w-6 h-6")
                            .fill("currentColor")
                            .viewBox("0 0 20 20")
                            .namespace("http://www.w3.org/2000/svg")

                            Span {"Toggle sidebar"}
                                .class("sr-only")

                      
                        }
                        .custom(key: "data-drawer-target", value: "drawer-navigation")
                        .custom(key: "data-drawer-toggle", value: "drawer-navigation")
                        .aria(controls: "drawer-navigation")
                        .class("p-2 mr-2 text-gray-600 rounded-lg cursor-pointer md:hidden hover:text-gray-900 hover:bg-gray-100 focus:bg-gray-100 dark:focus:bg-gray-700 focus:ring-2 focus:ring-gray-100 dark:focus:ring-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white")
                        
                        A {
                            Image()
                                .source("https://flowbite.s3.amazonaws.com/logo.svg")
                                .class("mr-3 h-8")
                                .alternate("Website Logo")

                            Span {
                                "TripPlanner"
                            }
                            .class("self-center text-2xl font-semibold whitespace-nowrap dark:text-white")
                        }
                        .reference("/protected/admin")
                        .class("flex items-center justify-between mr-4")
                        
                        Form {
                            Label {
                                "Search"
                            }
                            .for("topbar-search")
                            .class("sr-only")
                              
                            Div {
                                Div {
                                    Svg {
                                        Path {}
                                            .custom(key: "fill-rule", value: "evenodd")
                                            .custom(key: "clip-rule", value: "evenodd")
                                            .draw("M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z")
                                    }
                                    .class("w-5 h-5 text-gray-500 dark:text-gray-400")
                                    .fill("currentColor")
                                    .viewBox("0 0 20 20")
                                    .namespace("http://www.w3.org/2000/svg")
                                }
                                .class("flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none")
                                
                                Input()
                                    .type(.text)
                                    .name("topbar-search")
                                    .id("topbar-search")
                                    .class("bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full pl-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500")
                                    .placeholder("Search")
                            }
                            .class("relative md:w-64 md:w-96")
                        }
                        .method(.get)
                        .action("#")
                        .class("hidden md:block md:pl-2")
                        
                    }.class("flex justify-start items-center")
                    
                    NotificationView(button: button)
                }
                .class("flex flex-wrap justify-between items-center")
            }
            .class("bg-white border-b border-gray-200 px-4 py-2.5 dark:bg-gray-800 dark:border-gray-700 fixed left-0 right-0 top-0 z-50")
        }
    }
    
    struct SideBarNavView: View {
        
        struct SideBarMenu {
            let name: String
            let path: String
            let count: String?
        }
        
        let sideBarMenus: [SideBarMenu] = [
            .init(name: "Overview", path: "/protected/admin/dashboard", count: nil),
            .init(name: "Drivers", path: "/protected/admin/workers", count: "45"),
            .init(name: "Passangers", path: "/protected/admin/passangers", count: nil),
            .init(name: "Assistence", path: "/protected/admin/assistence", count: nil),
            .init(name: "Trips", path: "/protected/admin/trips", count: nil),
        ]
        
        let sideBarMenusBotton: [SideBarMenu] = [
            .init(name: "Docs", path: "/protected/admin/docs", count: nil)
        ]
        
        var body: Content {
            Ul {
                for menu in sideBarMenus {
                    Li {
                        A {
                            Span {
                                menu.name
                            }
                            .class("flex-1 ml-3 whitespace-nowrap")
                            
                            if menu.count != nil {
                                Span {
                                    menu.count
                                }
                                .class("inline-flex justify-center items-center w-5 h-5 text-xs font-semibold rounded-full text-primary-800 bg-primary-100 dark:bg-primary-200 dark:text-primary-800")
                            }
                        }
                        .reference(menu.path)
                        .class("flex items-center p-2 text-base font-medium text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group")
                    }
                }
            }
            .class("space-y-2")
            Ul {
                for menu in sideBarMenusBotton {
                    Li {
                        A {
                            Span {
                                menu.name
                            }
                            .class("ml-3")
                        }
                        .reference(menu.path)
                        .class("flex items-center p-2 text-base font-medium text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group")
                    }
                }
            }
            .class("pt-5 mt-5 space-y-2 border-t border-gray-200 dark:border-gray-700")
        }
    }
    
    struct SideBarView: View {
        var body: Content {
            Aside {
                Div {
                    Form {
                        Label {
                            "Search"
                        }
                        .for("sidebar-search")
                        .class("sr-only")
                        Div {
                            Div {
                                Svg {
                                    Path { }
                                        .custom(key: "fill-rule", value: "evenodd")
                                        .custom(key: "clip-rule", value: "evenodd")
                                        .draw("M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z")
                                }
                                .class("w-5 h-5 text-gray-500 dark:text-gray-400")
                                .fill("currentColor")
                                .viewBox("0 0 20 20")
                                .namespace("http://www.w3.org/2000/svg")
                            }
                            .class("flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none")
                            
                            Input()
                                .type(.text)
                                .name("search")
                                .id("sidebar-search")
                                .class("bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full pl-10 p-2 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500")
                                .placeholder("Search")
                        }
                        .class("relative")
                    }
                    .method(.get)
                    .action("#")
                    .class("md:hidden mb-2")
                    
                    SideBarNavView()
                    
                }
                .class("overflow-y-auto py-5 px-3 h-full bg-white dark:bg-gray-800")
                Div {
                    A {
                        Svg {
                            Path { }
                            .draw("M5 4a1 1 0 00-2 0v7.268a2 2 0 000 3.464V16a1 1 0 102 0v-1.268a2 2 0 000-3.464V4zM11 4a1 1 0 10-2 0v1.268a2 2 0 000 3.464V16a1 1 0 102 0V8.732a2 2 0 000-3.464V4zM16 3a1 1 0 011 1v7.268a2 2 0 010 3.464V16a1 1 0 11-2 0v-1.268a2 2 0 010-3.464V4a1 1 0 011-1z")
                            
                        }
                        .custom(key: "aria-hidden", value: true)
                        .class("w-6 h-6")
                        .fill("currentColor")
                        .viewBox("0 0 20 20")
                        .namespace("http://www.w3.org/2000/svg")
                    }
                    .reference("#")
                        .class("inline-flex justify-center p-2 text-gray-500 rounded cursor-pointer dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-600")
                    A {
                        Svg {
                            Path { }
                            .draw("M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z")
                            .custom(key: "clip-rule", value: "evenodd")
                            .custom(key: "fill-rule", value: "evenodd")
                            
                        }
                        .custom(key: "aria-hidden", value: true)
                        .class("w-6 h-6")
                        .fill("currentColor")
                        .viewBox("0 0 20 20")
                        .namespace("http://www.w3.org/2000/svg")
                    }
                    .reference("#")
                    .custom(key: "data-tooltip-target", value: "tooltip-settings")
                        .class("inline-flex justify-center p-2 text-gray-500 rounded cursor-pointer dark:text-gray-400 dark:hover:text-white hover:text-gray-900 hover:bg-gray-100 dark:hover:bg-gray-600")

                    Div {
                        "Settings page"
                        Div {}
                        .custom(key: "data-popper-arrow", value: "")
                        .class("tooltip-arrow")
                    }
                    .id("tooltip-settings")
                    .role(.tooltip)
                    .class("inline-block absolute invisible z-10 py-2 px-3 text-sm font-medium text-white bg-gray-900 rounded-lg shadow-sm opacity-0 transition-opacity duration-300 tooltip")
                    
                    Button {
                        Svg {
                            Path {}
                                .draw("M0 0h7410v3900H0z")
                                .fill("#b22234")
                                
                            
                            Path {}
                                .draw("M0 450h7410m0 600H0m0 600h7410m0 600H0m0 600h7410m0 600H0")
                                .stroke("fff")
                                .strokeWidth(300)
                            
                            Path {}
                                .draw("M0 0h2964v2100H0z")
                                .fill("#3c3b6e")
                            
                            // G Part
                        }
                        .custom(key: "aria-hidden", value: true)
                        .class("h-5 w-5 rounded-full mt-0.5")
                        .viewBox("0 0 3900 3900")
                    }
                    .type(.button)
                    .custom(key: "data-dropdown-toggle", value: "language-dropdown")
                    .class("inline-flex justify-center p-2 text-gray-500 rounded cursor-pointer dark:hover:text-white dark:text-gray-400 hover:text-gray-900 hover:bg-gray-100 dark:hover:bg-gray-600")
                    
                    Div {
                        Ul {
                            Li {
                               "name 1"
                            }
                            Li {
                                "name 2"
                            }
                        }
                        .class("py-1")
                        .role(.none)
                    }
                    .id("language-dropdown")
                    .class("hidden z-50 my-4 text-base list-none bg-white rounded divide-y divide-gray-100 shadow dark:bg-gray-700")
                }
                .class("hidden absolute bottom-0 left-0 justify-center p-4 space-x-4 w-full lg:flex bg-white dark:bg-gray-800 z-20")
            }
            .class("fixed top-0 left-0 z-40 w-64 h-screen pt-14 transition-transform sm:translate-x-0 -translate-x-full bg-white border-r border-gray-200 md:translate-x-0 dark:bg-gray-800 dark:border-gray-700")
            .aria(label: "Sidenav")
            .aria(hidden: true)
            .id("drawer-navigation")
        }
    }
    
    struct NotificationView: View {
        let button: String?
        
        var body: Content {
            Div {
                Button {
                    Span { "Toggle search" }.class("sr-only")
                    Svg {
                        Path {}
                            .custom(key: "clip-rule", value: "evenodd")
                            .custom(key: "fill-rule", value: "evenodd")
                            .draw("M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z")
                    }
                    .class("w-6 h-6")
                    .fill("currentColor")
                    .viewBox("0 0 20 20")
                }
                .type(.button)
                .class("p-2 mr-1 text-gray-500 rounded-lg md:hidden hover:text-gray-900 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-700 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600")
                
                if let button = button {
                    A {
                        Svg {
                            Path {}
                                .custom(key: "clip-rule", value: "evenodd")
                                .custom(key: "fill-rule", value: "evenodd")
                                .draw("M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z")
                        }
                        
                        .class("mr-1 -ml-1 w-5 h-5")
                        .fill("currentColor")
                        .viewBox("0 0 20 20")
                        
                        " New \(button)"
                    }
                    .reference("/protected/admin/\(button.lowercased())/create")
                    .type("button")
                    .class("hidden sm:inline-flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-xs px-3 py-1.5 mr-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800")
                }
                
                // Notifications
                Button {
                    Span { "View notifications" }.class("sr-only")
                    Svg {
                        Path {}
                            .draw("M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z")
                    }
                    .class("w-6 h-6")
                    .fill("currentColor")
                    .viewBox("0 0 20 20")
                }
                .type(.button)
                .custom(key: "data-dropdown-toggle", value: "notification-dropdown")
                .class("p-2 mr-1 text-gray-500 rounded-lg hover:text-gray-900 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-700 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600")
                // Dropdown menu
                
                Div {
                    Div {
                        "Notifications"
                    }
                    .class("block py-2 px-4 text-base font-medium text-center text-gray-700 bg-gray-50 dark:bg-gray-600 dark:text-gray-300")
                    Div {
                        NotificationItem(name: "Bonnie Green", message: "Hey, what's up? All set for the presentation?", time: "a few moments ago", avatar: "https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/bonnie-green.png", icon: "bg-primary-700")
                        NotificationItem(name: "Jese Leos", message: "and 5 others started following you.", time: "10 minutes ago", avatar: "https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/jese-leos.png", icon: "bg-gray-900")
                        NotificationItem(name: "Joseph McFall", message: "and 141 others love your story. See it and view more stories.", time: "44 minutes ago", avatar: "https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/joseph-mcfall.png", icon: "bg-red-600")
                        NotificationItem(name: "Leslie Livingston", message: "mentioned you in a comment: @bonnie.green what do you say?", time: "1 hour ago", avatar: "https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/roberta-casas.png", icon: "bg-green-400")
                        NotificationItem(name: "Robert Brown", message: "posted a new video: Glassmorphism - learn how to implement the new design trend.", time: "3 hours ago", avatar: "https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/robert-brown.png", icon: "bg-purple-500")
                    }
                    A {
                        Div {
                            Svg {
                                Path {}
                                    .draw("M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z")
                            }
                            .class("mr-2 w-4 h-4 text-gray-500 dark:text-gray-400")
                            .fill("currentColor")
                            .viewBox("0 0 20 20")

                            "See all"
                        }
                        .class("inline-flex items-center")
                    }
                    .reference("#")
                    .class("block py-2 text-md font-medium text-center text-gray-900 bg-gray-50 hover:bg-gray-100 dark:bg-gray-600 dark:text-white dark:hover:underline")
                }
                .id("notification-dropdown")
                .class("hidden overflow-hidden z-50 my-4 max-w-sm text-base list-none bg-white rounded divide-y divide-gray-100 shadow-lg dark:divide-gray-600 dark:bg-gray-700 rounded-xl")
            }
            .class("flex items-center lg:order-2")
        }

        private func NotificationItem(name: String, message: String, time: String, avatar: String, icon: String) -> Content {
            A {
                Div {
                    Img()
                        .class("w-11 h-11 rounded-full")
                        .source(avatar)
                        .alternate("\(name) avatar")
                    Div {
                        Svg {
                            Path {}
                                .draw("M8.707 7.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l2-2a1 1 0 00-1.414-1.414L11 7.586V3a1 1 0 10-2 0v4.586l-.293-.293z")
                            Path {}
                                .draw("M3 5a2 2 0 012-2h1a1 1 0 010 2H5v7h2l1 2h4l1-2h2V5h-1a1 1 0 110-2h1a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2V5z")
                        }
                        .class("w-3 h-3 text-white")
                        .fill("currentColor")
                        .viewBox("0 0 20 20")
                        

                    }
                    .class("flex absolute justify-center items-center ml-6 -mt-5 w-5 h-5 \(icon) rounded-full border border-white dark:border-gray-700")
                }.class("flex-shrink-0")
                
                Div {
                    Div {
                        "New message from "
                        Span { name }.class("font-semibold text-gray-900 dark:text-white")
                        ": \(message)"
                    }
                    .class("text-gray-500 font-normal text-sm mb-1.5 dark:text-gray-400")
                    Div {
                        time
                    }
                    .class("text-xs font-medium text-primary-600 dark:text-primary-500")
                }.class("pl-3 w-full")
            }
            .reference("#")
            .class("flex py-3 px-4 border-b hover:bg-gray-100 dark:hover:bg-gray-600 dark:border-gray-600")
        }
    }

}

