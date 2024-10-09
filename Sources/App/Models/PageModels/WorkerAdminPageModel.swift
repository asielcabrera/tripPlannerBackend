//
//  WorkerAdminPageModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

enum  WorkerAdminPageModel {
    struct IndexView {
        let title: String = "Worker Page"
        let user: UserModel.Output
        var pagination: Pagination<[DriverModel.Output]>
        
        init(user: UserModel.Output, pagination: Pagination<[DriverModel.Output]>) {
            self.user = user
            self.pagination = pagination
        }
    }
    
    struct CreateView {
        let title: String = "Create Driver"
    }
}
