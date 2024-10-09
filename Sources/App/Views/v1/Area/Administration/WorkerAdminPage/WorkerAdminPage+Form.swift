//
//  WorkerAdminPage+Form.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKit
import HTMLKitComponents

extension WorkerAdminPage {
    
    struct CreateForm: View {
        
        var body: Content {
            Form(method: .post) {
                VStack {
                    FieldLabel(for: "firstName") {
                        "Name"
                    }
                    TextField(name: "firstName", prompt: "Name")
                        .borderShape(.smallrounded)
                }
                
                VStack {
                    FieldLabel(for: "lastName") {
                        "Lastname"
                    }
                    TextField(name: "lastName", prompt: "Lastname")
                        .borderShape(.smallrounded)
                }
                
                VStack {
                    FieldLabel(for: "username") {
                        "email"
                    }
                    TextField(name: "username", prompt: "Email")
                        .borderShape(.smallrounded)
                }
                
                VStack {
                    FieldLabel(for: "password") {
                        "Password"
                    }
                    TextField(name: "password", prompt: "Password")
                        .borderShape(.smallrounded)
                }
              
                HStack(spacing: .small) {
                    VStack {
                        FieldLabel(for: "Role") {
                            "Role"
                        }
                        SelectField(name: "role", prompt: "Role") {
                            for role in UserModel.Roles.allCases {
                                RadioSelect(value: role.rawValue) {
                                    role.description
                                }
                            }
                        }
                        .borderShape(.smallrounded)
                    }
                }
                .margin(insets: .bottom, length: .large)
                Button(role: .submit) {
                    "Submit"
                }
                .buttonStyle(.primary)
                .borderShape(.smallrounded)
            }
            .tag("create-form")
            .onSubmit { form in
                form.validate("create-form", DriverModel.Input.validators)
            }
        }
    }
    
    struct EditForm: View {
        
        var driver: DriverModel.Output
        
        var body: Content {
            Form(method: .post) {
                VStack {
                    FieldLabel(for: "name") {
                        "Name"
                    }
                    TextField(name: "name", prompt: "Name", value: driver.firstName)
                        .borderShape(.smallrounded)
                }
                HStack(spacing: .small) {
                    VStack {
                        FieldLabel(for: "role") {
                            "Role"
                        }
                        SelectField(name: "role", prompt: "Role", selection: driver.role) {
                            for role in UserModel.Roles.allCases {
                                RadioSelect(value: role.rawValue) {
                                    role.description
                                }
                            }
                        }
                        .borderShape(.smallrounded)
                    }
                }
                .margin(insets: .bottom, length: .large)
                Button(role: .submit) {
                    "Submit"
                }
                .buttonStyle(.primary)
                .borderShape(.smallrounded)
            }
            .tag("edit-form")
            .onSubmit { form in
                form.validate("edit-form", DriverModel.Input.validators)
            }
        }
    }
}
