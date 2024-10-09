//
//  AuthenticationPage+Form.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/9/24.
//

import HTMLKit

extension AuthenticationPage {
    struct LoginFormView: View {
        @EnvironmentObject(Nonce.self)
        var nonce
        
        var body: Content {
            Form {
                Div {
                    Label { "Your email" }
                        .for("email")
                        .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                    
                    Input()
                        .type(.email)
                        .name("email")
                        .id("email")
                        .class("bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                        .placeholder("name@company.com")
                        .required(true)
                }
                
                Div {
                    Label { "Password" }
                        .for("password")
                        .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                    
                    Input()
                        .type(.password)
                        .name("password")
                        .id("password")
                        .class("bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                        .placeholder("••••••••")
                        .required(true)
                }
                
                Div {
                    Div {
                        Input()
                            .type(.checkbox)
                            .id("remember")
                            .class("w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800")
                        
                        Div {
                            Label { "Remember me" }
                                .for("remember")
                                .class("text-gray-500 dark:text-gray-300")
                        }
                        .class("ml-3 text-sm")
                    }
                    .class("flex items-start")
                    
                    A { "Forgot password?" }
                        .reference("#")
                        .class("text-sm font-medium text-primary-600 hover:underline dark:text-primary-500")
                }
                .class("flex items-center justify-between")
                
                Input()
                    .type(.hidden)
                    .name("nonce")
                    .custom(key: "value", value: nonce.value)
                
                Button { "Sign in" }
                    .type(.submit)
                    .class("w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800")
            }
            .method(.post)
            .id("wf-form-password")
            .class("space-y-4 md:space-y-6")
        }
    }
    
    struct ResetFromView: View {
        @EnvironmentObject(Nonce.self)
        var nonce
        
        var body: Content {
            Form {
                Div {
                    Label { "Password" }
                        .for("password")
                        .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                    
                    Input()
                        .type(.password)
                        .name("password")
                        .id("password")
                        .class("bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                        .placeholder("••••••••")
                        .required(true)
                }
                
                Div {
                    Label { "Confirm Password" }
                        .for("confirm-password")
                        .class("block mb-2 text-sm font-medium text-gray-900 dark:text-white")
                    
                    Input()
                        .type(.password)
                        .name("confirm-password")
                        .id("confirm-password")
                        .class("bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500")
                        .placeholder("••••••••")
                        .required(true)
                }
                
                
                Input()
                    .type(.hidden)
                    .name("nonce")
                    .custom(key: "value", value: nonce.value)
 
                Button { "Reset Password" }
                    .type(.submit)
                    .class("w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800")

            }
            .id("wf-form-password")
            .class("space-y-4 md:space-y-6")
        }
    }
}
