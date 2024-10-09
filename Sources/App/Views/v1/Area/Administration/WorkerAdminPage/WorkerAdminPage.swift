//
//  WorkerAdminPage.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//
import HTMLKit
import HTMLKitComponents

enum WorkerAdminPage {
    struct IndexView: View {
        
        var viewModel: WorkerAdminPageModel.IndexView
        
        var body: Content {
            AreaViewContainer(identity: viewModel.user) {
                Header {
                    HStack(spacing: .between) {
                        Text {
                            viewModel.title
                        }
                        .fontSize(.medium)
                        .fontWeight(.medium)
                        
                        LinkButton(destination: "/area/admin/workers/create") {
                            Symbol(system: .file)
                            Text {
                                "Create"
                            }
                        }
                        .buttonStyle(.primary)
                        .borderShape(.smallrounded)
                    }
                }
                Section {
                    WorkerList(drivers: viewModel.pagination.items)
                    HStack(spacing: .between) {
                        PagePagination(meta: viewModel.pagination.meta)
                    }
                }
            }
        }
    }
    
    struct CreateView: View {
     
        var viewModel: WorkerAdminPageModel.CreateView
        
        var body: Content {
            AreaViewContainer {
                Header {
                    HStack {
                        Text {
                            viewModel.title
                        }
                        .fontSize(.medium)
                        .fontWeight(.medium)
                    }
                }
                Section {
                    VStack {
                        WorkerAdminPage.CreateForm()
                    }
                }
            }
        }
    }
    
}
