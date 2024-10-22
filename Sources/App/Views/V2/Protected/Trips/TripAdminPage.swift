//
//  TripAdminPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/13/24.
//

import HTMLKit
import Foundation

enum TripAdminPage {
    struct IndexView: View {
        
        let weekSelected: Int
        
        var trips: [TripModel.Output]
        
        var body: Content {
            DashboardAdminPage.BaseDashboardAdminPage() {
                Div {
                    Div {
                        H3 {
                            "Trips"
                        }
                        .class("text-xl font-semibold text-gray-900 dark:text-white")
                    }
                    .class("flex items-start justify-between p-4 border-b rounded-t mb-4 dark:border-gray-600 ")
                    
                    Div {
                        Form {
                            Select {
                                
                                Option {
                                    "Select a week"
                                }
                                
                                for week in (1...52) {
                                    if week == weekSelected {
                                        Option {
                                            "Week \(week)"
                                        }
                                        .value("\(week)")
                                        .selected()
                                        
                                    } else {
                                        Option {
                                            "Week \(week)"
                                        }
                                        .value("\(week)")
                                    }
                                }
                            }
                            .id("week")
                            .name("week")
                            .class("bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                            
                            Button {
                                "Search"
                            }
                            .type(.submit)
                            .class("text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800")
                            
                            
                        }
                        .method(.get)
                        .class("flex justify-around w-full max-w-md")
                        
                    }
                    .class("flex max-h-full items-start justify-between p-4 border-b rounded-t mb-4 dark:border-gray-600 ")
                    
                    Div {
                        //                        AcordionListCell(trips: trips)
                        ListWeekTripsView(trips: trips)
                    }
                    .id("accordion-collapse")
                    .custom(key: "data-accordion", value: "open")
                    .class("mb-4")
                }
                .class("relative w-full max-w-2xl max-h-full")
            }
        }
    }
    
    
    
    
    
    struct AcordionListCell: View {
        
        var trips: [TripModel.Output]
        
        func header(trip: TripModel.Output) -> Content {
            H2 {
                Button {
                    Span {
                        "\(trip.forDay)"
                    }
                    
                    Span {
                        "\(trip.status)"
                    }
                    
                    Svg {
                        Path {}
                            .stroke("currentColor")
                            .strokeLineCap(.round)
                            .strokeLineJoin(.round)
                            .strokeWidth(2)
                            .draw("M9 5 5 1 1 5")
                    }
                    .fill("none")
                    .class("w-3 h-3 rotate-180 shrink-0")
                    .custom(key: "aria-hidden", value: true)
                    .custom(key: "data-accordion-icon", value: "")
                }
                .type(.button)
                .class("flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 rounded-t-xl focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3")
                .custom(key: "data-accordion-target", value: "#accordion-collapse-body-\(trip.id)")
                .custom(key: "aria-expanded", value: true)
                .aria(controls: "accordion-collapse-body-\(trip.id)")
            }
            .id("accordion-collapse-heading-\(trip.id)")
            
        }
        
        func collapseArea(trip: TripModel.Output) -> Content {
            Div {
                Div {
                    P {
                        "Flowbite is an open-source library of interactive components built on top of Tailwind CSS including buttons, dropdowns, modals, navbars, and more."
                    }
                    .class("mb-2 text-gray-500 dark:text-gray-400")
                    
                    P {
                        "Check out this guide to learn how to get started and start developing websites even faster with components on top of Tailwind CSS."
                    }
                    .class("text-gray-500 dark:text-gray-400")
                }
                .class("p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900")
            }
            .id("accordion-collapse-body-\(trip.id)")
            .class("hidden")
            .aria(labeledBy: "accordion-collapse-heading-\(trip.id)")
        }
        
        var body: Content {
            for trip in trips {
                if trip.forDay == trips[0].forDay {
                    Div {
                        
                        header(trip: trip)
                        
                        collapseArea(trip: trip)
                    }
                }
                else if let last = trips.last, trip.forDay == last.forDay {
                    Div {
                        H2 {
                            Button {
                                Span {
                                    "\(trip.forDay)"
                                }
                                
                                Span {
                                    "\(trip.status)"
                                }
                                
                                Svg {
                                    Path {}
                                        .stroke("currentColor")
                                        .strokeLineCap(.round)
                                        .strokeLineJoin(.round)
                                        .strokeWidth(2)
                                        .draw("M9 5 5 1 1 5")
                                }
                                .fill("none")
                                .class("w-3 h-3 rotate-180 shrink-0")
                                .custom(key: "aria-hidden", value: true)
                                .custom(key: "data-accordion-icon", value: "")
                            }
                            .type(.button)
                            .class("flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 rounded-b-xl focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3")
                            .custom(key: "data-accordion-target", value: "#accordion-collapse-body-\(trip.id)")
                            .custom(key: "aria-expanded", value: true)
                            .aria(controls: "accordion-collapse-body-\(trip.id)")
                        }
                        .id("accordion-collapse-heading-\(trip.id)")
                        
                        Div {
                            Div {
                                P {
                                    "Flowbite is an open-source library of interactive components built on top of Tailwind CSS including buttons, dropdowns, modals, navbars, and more."
                                }
                                .class("mb-2 text-gray-500 dark:text-gray-400")
                                
                                P {
                                    "Check out this guide to learn how to get started and start developing websites even faster with components on top of Tailwind CSS."
                                }
                                .class("text-gray-500 dark:text-gray-400")
                            }
                            .class("p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900")
                        }
                        .id("accordion-collapse-body-\(trip.id)")
                        .class("hidden")
                        .aria(labeledBy: "accordion-collapse-heading-\(trip.id)")
                    }
                } else {
                    Div {
                        H2 {
                            Button {
                                Span {
                                    "\(trip.forDay)"
                                }
                                Span {
                                    "\(trip.status)"
                                }
                                Svg {
                                    Path {}
                                        .stroke("currentColor")
                                        .strokeLineCap(.round)
                                        .strokeLineJoin(.round)
                                        .strokeWidth(2)
                                        .draw("M9 5 5 1 1 5")
                                }
                                .fill("none")
                                .class("w-3 h-3 rotate-180 shrink-0")
                                .custom(key: "aria-hidden", value: true)
                                .custom(key: "data-accordion-icon", value: "")
                            }
                            .type(.button)
                            .class("flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3")
                            .custom(key: "data-accordion-target", value: "#accordion-collapse-body-\(trip.id)")
                            .custom(key: "aria-expanded", value: true)
                            .aria(controls: "accordion-collapse-body-\(trip.id)")
                        }
                        .id("accordion-collapse-heading-\(trip.id)")
                        
                        Div {
                            Div {
                                P {
                                    "Flowbite is an open-source library of interactive components built on top of Tailwind CSS including buttons, dropdowns, modals, navbars, and more."
                                }
                                .class("mb-2 text-gray-500 dark:text-gray-400")
                                
                                P {
                                    "Check out this guide to learn how to get started and start developing websites even faster with components on top of Tailwind CSS."
                                }
                                .class("text-gray-500 dark:text-gray-400")
                            }
                            .class("p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900")
                        }
                        .id("accordion-collapse-body-\(trip.id)")
                        .class("hidden")
                        .aria(labeledBy: "accordion-collapse-heading-\(trip.id)")
                    }
                }
            }
        }
    }
    
    struct ListWeekTripsView: View {
        var trips: [TripModel.Output]
        
        var body: Content {
            
            Ul {
                for trip in trips {
                    Li {
//                        Div {
//                            Div {
//                                Div {
//                                    P {
//                                        "Trip of \(trip.forDay.weekDay) \(trip.forDay.formatted(date: .medium, time: .none))"
//                                    }
//                                    .class("text-sm font-medium text-gray-900 truncate dark:text-white")
//                                    
//                                    P {
//                                        "Status: \(trip.status.rawValue.capitalized)"
//                                    }
//                                    .class("text-sm text-gray-500 truncate dark:text-gray-400")
//                                }
//                                .class("flex-1 min-w-0")
//                                
//                                Div {
//                                    //                                    "\(trip.routes.count)"
//                                    "4"
//                                }
//                                .class("inline-flex items-center text-base font-semibold text-gray-900 dark:text-white")
//                            }
//                            .class("flex items-center space-x-4 rtl:space-x-reverse justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 \(rounderClass(trip)) focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3")
//                            .custom(key: "data-accordion-target", value: "#accordion-collapse-body-\(trip.id)")
//                            .custom(key: "aria-expanded", value: true)
//                            .aria(controls: "accordion-collapse-body-\(trip.id)")
//                            
//                        }
//                        .id("accordion-collapse-heading-\(trip.id)")
//                        
//                        Div {
//                            Div {
//                                P {
//                                    "Flowbite is an open-source library of interactive components built on top of Tailwind CSS including buttons, dropdowns, modals, navbars, and more."
//                                }
//                                .class("mb-2 text-gray-500 dark:text-gray-400")
//                                
//                                P {
//                                    "Check out this guide to learn how to get started and start developing websites even faster with components on top of Tailwind CSS."
//                                }
//                                .class("text-gray-500 dark:text-gray-400")
//                            }
//                            .class("p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900")
//                        }
//                        .id("accordion-collapse-body-\(trip.id)")
//                        .class("hidden")
//                        .aria(labeledBy: "accordion-collapse-heading-\(trip.id)")
//                        
//                        
                        
                        Div {
                            Button {
                                Span {
                                    "Trip of \(trip.forDay.weekDay) \(trip.forDay.formatted(date: .medium, time: .none))"
                                }
                                
                                Span {
                                    Svg {
                                        Path { }
                                            .draw("M11.78 9.78a.75.75 0 0 1-1.06 0L8 7.06 5.28 9.78a.75.75 0 0 1-1.06-1.06l3.25-3.25a.75.75 0 0 1 1.06 0l3.25 3.25a.75.75 0 0 1 0 1.06Z")
                                            .custom(key: "fill-rule", value: "evenodd")
                                            .custom(key: "clip-rule", value: "evenodd")
                                    }
                                    .viewBox("0 0 16 16")
                                    .class("w-4 h-4")
                                }
                                .id("icon-\(trip.id)")
                                .class("text-slate-800 transition-transform duration-300")
                            }
                            .class("w-full flex justify-between items-center py-5 text-slate-800")
                            .custom(key: "data-accordion-target", value: "#accordion-collapse-body-\(trip.id)")
                            .custom(key: "aria-expanded", value: true)
                            .aria(controls: "accordion-collapse-body-\(trip.id)")
                            .id("accordion-collapse-heading-\(trip.id)")
                            
                            Div {
                                Div {
                                    "hola mundo"
                                }
                                .class("pb-5 text-sm text-slate-500")
                            }
                            .id("accordion-collapse-body-\(trip.id)")
                            .class("hidden")
                            .aria(labeledBy: "accordion-collapse-heading-\(trip.id)")
                            .class("max-h-0 overflow-hidden transition-all duration-300 ease-in-out")
                            
                        }
                        
                        .class("border-b border-slate-200")
                    }
                }
            }
            .class("max-w-md divide-y divide-gray-200 dark:divide-gray-700")
        }
        
        private func rounderClass(_ trip: TripModel.Output) -> String {
            let first = trips.first
            let last = trips.last
            
            if let first = first, trip == first {
                return "rounded-t-xl"
            } else if let last = last, last == trip {
                return "rounded-b-xl"
            } else {
                return ""
            }
        }
    }
}
