//
//  PassangersAdminPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import HTMLKit

enum PassangersAdminPage {
    struct IndexView: View {
        
        let viewModel: PassangersAdminPageModel.IndexView
        
        var body: Content {
            DashboardAdminPage.BaseDashboardAdminPage("Passangers") {
                Div {
                    Div {
                        Label {
                            "Search"
                        }
                        .for("table-search")
                        .class("sr-only")
                        
                        Div {
                            Div {
                                Svg {
                                    Path {}
                                        .stroke("currentColor")
                                        .strokeLineCap(.round)
                                        .strokeLineJoin(.round)
                                        .strokeWidth(2)
                                        .draw("m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z")
                                }
                                .custom(key: "aria-hidden", value: true)
                                .fill("none")
                                .viewBox("0 0 20 20")
                                .class("w-4 h-4 text-gray-500 dark:text-gray-400")
                            }
                            .class("absolute inset-y-0 rtl:inset-r-0 start-0 flex items-center ps-3 pointer-events-none")
                            
                            Input()
                                .type(.text)
                                .id("table-search-workers")
                                .class("block pt-2 ps-10 text-sm text-gray-900 border border-gray-300 rounded-lg w-80 bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                .placeholder("Search for workers")
                            
                        }
                        .class("relative")
                    }
                    .class("flex items-center justify-between flex-column md:flex-row flex-wrap space-y-4 md:space-y-0 py-4 bg-white dark:bg-gray-900")
                    PassangerAdminPage.ListPassangerView(pagination: viewModel.pagination)
                }
                .class("relative overflow-x-auto shadow-md sm:rounded-lg")
            }
        }
    }
    
    struct CreateView: View {
        var body: Content {
            DashboardAdminPage.BaseDashboardAdminPage("Driver") {
                Div {
                    Form {
                        // Modal Header
                        Div {
                            H3 {
                                "Add a new worker"
                            }
                            .class("text-xl font-semibold text-gray-900 dark:text-white")
                        }
                        .class("flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600")
                        
                        // body
                        Div {
                            Div {
                                Div {
                                    Label {
                                        "First Name"
                                    }
                                    .for("firstName")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("firstName")
                                        .id("first-name")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("Bonnie")
                                        .required()
                                }
                                .class("col-span-6 sm:col-span-3")
                                
                                
                                Div {
                                    Label {
                                        "Last Name"
                                    }
                                    .for("lastName")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("lastName")
                                        .id("lastName")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("Green")
                                        .required()
                                }
                                .class("col-span-6 sm:col-span-3")
                                
                                Div {
                                    Label {
                                        "Email"
                                    }
                                    .for("email")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.email)
                                        .name("email")
                                        .id("email")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("bonniegreen@example.com")
                                        .required()
                                }
                                .class("col-span-10 sm:col-span-6")
                                
                                Div {
                                    
                                    Label {
                                        "Role"
                                    }
                                    .for("role")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Select {
                                        
                                        Option {
                                            "Select a role"
                                        }
                                        .selected()
                                    
                                    for role in UserModel.Roles.allCases {
                                        Option {
                                            "\(role.description)"
                                        }
                                        .value("\(role.rawValue)")
                                    }
                                }
                                .id("role")
                                .name("role")
                                .class("bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                            
                                }
                                .class("col-span-6 sm:col-span-3")
                            }
                            .class("grid grid-cols-6 gap-6")
                        }
                        .class("p-6 space-y-6")
                        
                        // footer
                        Div {
                            Button {
                                "Save"
                            }
                            .type(.submit)
                            .class("text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800")
                        }
                        .class("flex items-center p-6 space-x-3 rtl:space-x-reverse border-t border-gray-200 rounded-b dark:border-gray-600")
                    }
                    .method(.post)
                    .class("relative bg-white rounded-lg shadow dark:bg-gray-700")
                }
                .class("relative w-full max-w-2xl max-h-full")
            }
        }
    }
    
    struct EditView: View {
        
        var viewModel: PassangersAdminPageModel.EditView
        
        var body: Content {
            DashboardAdminPage.BaseDashboardAdminPage("Driver") {
                Div {
                    Form {
                        // Modal Header
                        Div {
                            H3 {
                                "Edit a worker"
                            }
                            .class("text-xl font-semibold text-gray-900 dark:text-white")
                        }
                        .class("flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600")
                        
                        // body
                        Div {
                            Div {
                                Div {
                                    Label {
                                        "First Name"
                                    }
                                    .for("firstName")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("firstName")
                                        .id("first-name")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("Bonnie")
                                        .value("\(viewModel.passanger.firstName)")
                                        .required()
                                }
                                .class("col-span-6 sm:col-span-3")
                                
                                
                                Div {
                                    Label {
                                        "Last Name"
                                    }
                                    .for("lastName")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("lastName")
                                        .id("lastName")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("Green")
                                        .value("\(viewModel.passanger.lastName)")
                                        .required()
                                }
                                .class("col-span-6 sm:col-span-3")
                                
                                Div {
                                    Label {
                                        "Address"
                                    }
                                    .for("address")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("address")
                                        .id("address")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("bonniegreen@example.com")
                                        .value("\(viewModel.passanger.address)")
                                        .required()
                                }
                                .class("col-span-10 sm:col-span-6")
                                
                                Div {
                                    
                                    Label {
                                        "Assistence Day"
                                    }
                                    .for("assistence")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Select {
                                        
                                        Option {
                                            "Select a Day"
                                        }
                                       
                                    
                                        for weekday in WeekDayModel.allCases {
                                            Option {
                                                "\(weekday.rawValue)"
                                            }
                                            
                                            .value("\(weekday.rawValue)")
                                            .selected()
                                        
                                    }
                                    
                                }
                                .multiple()
                                .id("assistence")
                                .name("assistence")
                                .class("bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                            
                                }
                                .class("col-span-6 sm:col-span-3")
                            }
                            .class("grid grid-cols-6 gap-6")
                        }
                        .class("p-6 space-y-6")
                        
                        // footer
                        Div {
                            Button {
                                "Save"
                            }
                            .type(.submit)
                            .class("text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800")
                        }
                        .class("flex items-center p-6 space-x-3 rtl:space-x-reverse border-t border-gray-200 rounded-b dark:border-gray-600")
                    }
                    .method(.post)
                    .class("relative bg-white rounded-lg shadow dark:bg-gray-700")
                }
                .class("relative w-full max-w-2xl max-h-full")
            }
        }
    }
}
