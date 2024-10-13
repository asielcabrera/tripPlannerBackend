//
//  DriversAdminPage+List.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import HTMLKit

extension DriversAdminPage {
    struct ListDriverView: View {
        
        var pagination: Pagination<[UserModel.Output]>
        
        var body: Content {
            
            Table {
                Caption {
                    "Our Driver"
                    Paragraph {
                        " Browse a list of drivers."
                    }
                    .class("mt-1 text-sm font-normal text-gray-500 dark:text-gray-400")
                }
                .class("p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800")
                
                Thead {
                    Tr {
                        Th {
                            Div {
                                Input()
                                    .type(.checkbox)
                                    .id("checkbox-all-search")
                                    .class("w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600")
                                
                                Label {
                                    "checkbox"
                                }
                                .for("checkbox-all-search")
                                .class("sr-only")
                            }
                            .class("flex items-center")
                        }
                        .scope("col")
                        .class("p-4")
                        
                        Th {
                            "Name"
                        }
                        .scope("col")
                        .class("px-6 py-3")
                        
                        Th {
                            "Position"
                        }
                        .scope("col")
                        .class("px-6 py-3")
                        
                        Th {
                            "Action"
                        }
                        .scope("col")
                        .class("px-6 py-3")
                    }
                }
                .class("text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400")
                
                Tbody {
                    for driver in pagination.items {
                        DriverItemListView(driver: driver)
                    }
                }
                .class("text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400")
            }
            .class("w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400")
        }
    }
    
    struct DriverItemListView: View {
        let driver: UserModel.Output
        
        var body: Content {
            Tr {
                Td {
                    Div {
                        Input()
                            .type(.checkbox)
                            .id("checkbox-table-search-\(driver.id)")
                            .class("w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600")
                        
                        Label {
                            "checkbox"
                        }
                        .for("checkbox-table-search-\(driver.id)")
                        .class("sr-only")
                    }
                    .class("flex items-center")
                }
                .class("w-4 p-4")
                
                Th {
                    Image()
                        .class("w-10 h-10 rounded-full")
                        .source("https://flowbite.com/docs/images/people/profile-picture-1.jpg")
                        .alternate("\(String(describing: driver.firstName)) \(String(describing: driver.lastName)) image")
                    
                    Div {
                        Div {
                            "\(driver.fullname ?? "")"
                        }
                        .class("text-base font-semibold")
                        
                        Div {
                            "\(driver.email)"
                        }
                        .class("font-normal text-gray-500")
                    }
                    .class("ps-3")
                }
                .scope("row")
                .class("flex items-center px-6 py-4 text-gray-900 whitespace-nowrap dark:text-white")
                
                Td {
                    "\(driver.role)"
                }
                .class("px-6 py-4")
                
                
                Td {
                    A { "Edit " }
                        .type("button")
                        .class("text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800")
                        .reference("/protected/admin/drivers/edit/\(driver.id)")

           
                    A { " Delete" }
                        .type("button")
                        .class("focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900")
                        .reference("/protected/admin/drivers/delete/\(driver.id)")
                }
                .class("px-6 py-4")
            }
            .class("bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600")
        }
    }
    
    struct EditDriverModelView: View {
        var body: Content {
            Div {
                Div {
                    Form {
                        // Modal Header
                        Div {
                            H3 {
                                "Edit Driver"
                            }
                            .class("text-xl font-semibold text-gray-900 dark:text-white")
                            
                            Button {
                                
                                Svg {
                                    Path {}
                                        
                                        .strokeLineCap(.round)
                                        .strokeLineJoin(.round)
                                        .strokeWidth(2)
                                        .draw("m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6")
                                }
                                .custom(key: "aria-hidden", value: true)
                                .fill("none")
                                .class("w-3 h-3")
                                .viewBox("0 0 14 14")
                            }
                            .type(.button)
                            .custom(key: "data-modal-hide", value: "editDriverModal")
                            .class("text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white")
                        }
                        .class("flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600")
                        
                        // Modal body
                        Div {
                            Div {
                                Div {
                                    Label {
                                        "First Name"
                                    }
                                    .for("first-name")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("first-name")
                                        .id("first-name")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("Bonnie")
                                        .required()
                                }
                                .class("col-span-6 sm:col-span-3")
                                
                                // Repetir bloques similares para los otros campos
                                Div {
                                    Label {
                                        "Last Name"
                                    }
                                    .for("last-name")
                                    .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                                    
                                    Input()
                                        .type(.text)
                                        .name("last-name")
                                        .id("last-name")
                                        .class("shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                                        .placeholder("Green")
                                        .required()
                                }
                                .class("col-span-6 sm:col-span-3")
                            }
                            .class("grid grid-cols-6 gap-6")
                        }
                        .class("p-6 space-y-6")
                        
                        // Modal footer
                        Div {
                            Button {
                                "Save all"
                            }
                            .type(.submit)
                            .class("text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800")
                        }
                        .class("flex items-center p-6 space-x-3 rtl:space-x-reverse border-t border-gray-200 rounded-b dark:border-gray-600")
                    }
                    .class("relative bg-white rounded-lg shadow dark:bg-gray-700")
                }
                .class("relative w-full max-w-2xl max-h-full")
            }
            .id("editDriverModal")
            .tabIndex(-1)
            .aria(hidden: true)
            .class("fixed top-0 left-0 right-0 z-50 items-center justify-center hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full")
            
        }
    }
}
