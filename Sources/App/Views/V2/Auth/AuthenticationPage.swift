//
//  LoginView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

enum AuthenticationPage {
    
    struct BaseAuthLayout: View {
        
        let title: String
        var content: [BodyElement]
        
        
        init(_ title: String, @ContentBuilder<BodyElement> content: () -> [BodyElement]) {
            self.title = title
            self.content = content()
        }
        
        var body: Content {
            BaseContaiterView {
                Section {
                    Div {
                        A {
                            Img()
                                .source("https://flowbite.s3.amazonaws.com/blocks/marketing-ui/logo.svg")
                                .alternate("logo")
                                .class("w-8 h-8 mr-2")
                            "Community Connection Trip Planner"
                        }
                        .reference("#")
                        .class("flex items-center mb-6 text-2xl font-semibold text-gray-900 dark:text-white")
                        
                        Div {
                            Div {
                                H1 { title }
                                    .class("text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white")
                                
                                content
                            }
                            .class("p-6 space-y-4 md:space-y-6 sm:p-8")
                        }
                        .class("w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700")
                    }
                    .class("flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0")
                }
                .class("bg-gray-50 dark:bg-gray-900")
            
            }
        }
    }
    
    struct LoginPageView: View {
        var body: Content {
            BaseAuthLayout("Sign in to your account") {
                AuthenticationPage.LoginFormView()
            }
        }
    }
    
    struct ResetPageView: View {
        var body: Content {
            BaseAuthLayout("Reset your password") {
                AuthenticationPage.ResetFromView()
            }
        }
    }
}


