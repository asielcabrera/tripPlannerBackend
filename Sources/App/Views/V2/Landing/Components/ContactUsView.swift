//
//  ContactUsView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

struct ContactUsView: View {
    var body: Content {
        Section {
            Div {
                Div {
                    Div {
                        H2 {
                            "Let's build something exciting together!"
                        }
                        .class("mb-2 text-3xl font-bold md:text-5xl")
                        
                        Paragraph {
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus"
                        }
                        .class("my-4 max-w-lg pb-4 text-sm text-gray-500 sm:text-base md:mb-6 lg:mb-8")
                        
                        Div {
                            for _ in 1...5 { 
                                Svg {
                                    Path { }
                                    .fill("currentColor")
                                    .draw("m12 17.27l4.15 2.51c.76.46 1.69-.22 1.49-1.08l-1.1-4.72l3.67-3.18c.67-.58.31-1.68-.57-1.75l-4.83-.41l-1.89-4.46c-.34-.81-1.5-.81-1.84 0L9.19 8.63l-4.83.41c-.88.07-1.24 1.17-.57 1.75l3.67 3.18l-1.1 4.72c-.2.86.73 1.54 1.49 1.08l4.15-2.5z")
                                }
                                    .class("h-8 w-8")
                                    .namespace("http://www.w3.org/2000/svg")
                                    .width(24)
                                    .height(24)
                                    .custom(key: "preserveAspectRatio", value: "xMidYMid meet")
                                    .viewBox("0 0 24 24")
                            }
                        }
                        .class("mb-4 flex items-center text-orange-500")
                        
                        Paragraph {
                            "Lorem ipsum dolor sit amet, &nbsp;elit ut aliquam, purus sit amet luctus venenatis elit ut aliquam, purus sit amet luctus venenatis"
                        }
                        .class("mb-8 max-w-lg text-sm text-gray-500 sm:text-base")
                        
                        Div {
                            Img()
                                .source("https://firebasestorage.googleapis.com/v0/b/flowspark-1f3e0.appspot.com/o/Tailspark%20Images%2FPlaceholder%20Image.svg?alt=media&token=375a1ea3-a8b6-4d63-b975-aac8d0174074")
                                .class("mr-4 inline-block h-16 w-16 rounded-full object-cover")
                            Div {
                                H6 {
                                    "Laila Bahar"
                                }
                                .class("text-base font-bold")
                                
                                Paragraph {
                                    "Designer"
                                }
                                .class("text-sm text-gray-500")
                            }
                            .class("flex flex-col")
                        }
                        .class("flex")
                    }
                    .class("max-w-3xl")
                    Div {
                        H3 {
                            "Get a free quote"
                        }
                        .class("text-2xl font-bold md:text-3xl")
                        
                        Paragraph {
                            "Lorem ipsum dolor sit amet consectetur adipiscing elit ut aliquam,purus sit amet luctus magna fringilla urna"
                        }
                        .class("mx-auto mb-6 mt-4 max-w-lg text-sm text-gray-500 lg:mb-8")
                        
                        Form {
                            Div {
                                Label {
                                    "Your Name"
                                }
                                .custom(key: "htmlFor", value: "wf-form-name")
                                .class("mb-1 font-medium")
                                
                                Input()
                                    .type(.text)
                                    .class("mb-4 block h-9 w-full rounded-md border border-solid border-black px-3 py-6 pl-4 text-sm text-black")
                            }
                            
                            
                            Div {
                                Label {
                                    "Email Address"
                                }
                                .custom(key: "htmlFor", value: "wf-form-email")
                                .class("mb-1 font-medium")
                                
                                Input()
                                    .type(.text)
                                    .class("mb-4 block h-9 w-full rounded-md border border-solid border-black px-3 py-6 pl-4 text-sm text-black")
                            }
                            .class("mb-2")
                            
                            
                            Div {
                                Label {
                                    "Message"
                                }
                                .custom(key: "htmlFor", value: "wf-form-message")
                                .class("mb-1 font-medium")
                                
                                TextArea {
                                    
                                }
                                .placeholder("")
                                .name("name")
                                .maximum(length: 5000)
                                .class("mb-2.5 block h-auto min-h-32 w-full rounded-md border border-solid border-black p-3 text-sm text-black")
                            }
                            .class("mb-5 md:mb-6 lg:mb-8")
                            
                            Input()
                                .type(.submit)
                                .value("Contact Us")
                                .class("inline-block w-full cursor-pointer rounded-md bg-black px-6 py-3 text-center font-semibold text-white")
                        }
                        .class("mx-auto mb-4 max-w-sm text-left")
                        .name("wf-form-contactus")
                        .method(.post)
                    }
                    .class("mx-auto max-w-xl bg-gray-100 p-8 text-center")
                }
                .class("grid items-center gap-8 sm:gap-20 lg:grid-cols-2")
            }
            .class("mx-auto w-full max-w-7xl px-5 py-16 md:px-10 md:py-20")
        }
        .id("contactus")
    }
}
