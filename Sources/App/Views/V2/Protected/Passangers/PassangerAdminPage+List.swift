//
//  PassangerAdminPage+List.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

import HTMLKit

extension PassangerAdminPage {
    struct ListPassangerView: View {
        
        var pagination: Pagination<[PassangerModel.Output]>
        
        var body: Content {
            
            Table {
                Caption {
                    "Our Passanger"
                    Paragraph {
                        " Browse a list of Passangers."
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
                    for passanger in pagination.items {
                        PassangerItemListView(passanger: passanger)
                    }
                }
                .class("text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400")
            }
            .class("w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400")
        }
    }
    
    struct PassangerItemListView: View {
        let passanger: PassangerModel.Output
        
        var body: Content {
            Tr {
                Td {
                    Div {
                        Input()
                            .type(.checkbox)
                            .id("checkbox-table-search-\(passanger.id)")
                            .class("w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600")
                        
                        Label {
                            "checkbox"
                        }
                        .for("checkbox-table-search-\(passanger.id)")
                        .class("sr-only")
                    }
                    .class("flex items-center")
                }
                .class("w-4 p-4")
                
                Th {
                    Image()
                        .class("w-10 h-10 rounded-full")
                        .source("https://flowbite.com/docs/images/people/profile-picture-1.jpg")
                        .alternate("\(String(describing: passanger.firstName)) \(String(describing: passanger.lastName)) image")
                    
                    Div {
                        Div {
                            "\(passanger.fullname ?? "")"
                        }
                        .class("text-base font-semibold")
                        
                        Div {
                            "\(passanger.address)"
                        }
                        .class("font-normal text-gray-500")
                    }
                    .class("ps-3")
                }
                .scope("row")
                .class("flex items-center px-6 py-4 text-gray-900 whitespace-nowrap dark:text-white")
                
                Td {
                    "\(passanger.assistence)"
                }
                .class("px-6 py-4")
                
                
                Td {
                    A { "Edit " }
                        .type("button")
                        .class("text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800")
                        .reference("/protected/admin/drivers/edit/\(passanger.id)")

           
                    A { " Delete" }
                        .type("button")
                        .class("focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900")
                        .reference("/protected/admin/drivers/delete/\(passanger.id)")
                }
                .class("px-6 py-4")
            }
            .class("bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600")
        }
    }
}
