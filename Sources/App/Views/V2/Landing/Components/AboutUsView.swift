//
//  AboutUsView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

struct AboutUsView: View {
    var body: Content {
        Section {
            Div {
                Img()
                    .class("w-full dark:hidden")
                    .source("https://img1.wsimg.com/isteam/ip/7d611f15-d82a-43b2-9960-aa8b1e5a36b3/3.jpg")
                    .alternate("dashboard image")
                
                Img()
                    .class("w-full hidden dark:block")
                    .source("https://img1.wsimg.com/isteam/ip/7d611f15-d82a-43b2-9960-aa8b1e5a36b3/3.jpg")
                    .alternate("dashboard image")
                
                Div {
                    H2 {
                        "Group Therapy."
                    }
                    .class("mb-4 text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white")
                    
                    Paragraph {
                        "Each of our patients are eligible for this personalized service. Schedule yours today, and we promise you’ll leave our clinic well-informed and confident that your health is in the best of hands."
                    }
                    .class("mb-6 font-light text-gray-500 md:text-lg dark:text-gray-400")
                }
                .class("mt-4 md:mt-0")
            }
            .class("gap-8 items-center py-8 px-4 mx-auto max-w-screen-xl xl:gap-16 md:grid md:grid-cols-2 sm:py-16 lg:px-6")
            
            Div {
                Div {
                    H2 {
                        "Individual Therapy."
                    }
                    .class("mb-4 text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white")
                    
                    Paragraph {
                        "Each of our patients are eligible for this personalized service. Schedule yours today, and we promise you’ll leave our clinic well-informed and confident that your health is in the best of hands."
                    }
                    .class("mb-6 font-light text-gray-500 md:text-lg dark:text-gray-400")
                }
                .class("mt-4 md:mt-0")
                
                Img()
                    .class("w-full dark:hidden")
                    .source("https://img1.wsimg.com/isteam/ip/7d611f15-d82a-43b2-9960-aa8b1e5a36b3/8.jpg")
                    .alternate("dashboard image")
                
                Img()
                    .class("w-full hidden dark:block")
                    .source("https://img1.wsimg.com/isteam/ip/7d611f15-d82a-43b2-9960-aa8b1e5a36b3/8.jpg")
                    .alternate("dashboard image")
            }
            .class("gap-8 items-center py-8 px-4 mx-auto max-w-screen-xl xl:gap-16 md:grid md:grid-cols-2 sm:py-16 lg:px-6")
            
            Div {
                Img()
                    .class("w-full dark:hidden")
                    .source("https://img1.wsimg.com/isteam/ip/7d611f15-d82a-43b2-9960-aa8b1e5a36b3/9.jpg")
                    .alternate("dashboard image")
                
                Img()
                    .class("w-full hidden dark:block")
                    .source("https://img1.wsimg.com/isteam/ip/7d611f15-d82a-43b2-9960-aa8b1e5a36b3/9.jpg")
                    .alternate("dashboard image")
                
                Div {
                    H2 {
                        "Our Team."
                    }
                    .class("mb-4 text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white")
                    
                    Paragraph {
                        "Our professional team is here to guide our patients and their families every step of the way throughout their health journeys. At Community Connection Florida, we not only treat our patience with kindness and care, we also treat them as Family."
                    }
                    .class("mb-6 font-light text-gray-500 md:text-lg dark:text-gray-400")
                }
                .class("mt-4 md:mt-0")
            }
            .class("gap-8 items-center py-8 px-4 mx-auto max-w-screen-xl xl:gap-16 md:grid md:grid-cols-2 sm:py-16 lg:px-6")
        }
        .class("bg-white dark:bg-gray-900")
    }
}
