//
//  DriverAdminPageModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/9/24.
//

enum DriverAdminPageModel {
    struct IndexView {
        let title: String = "Driver Page"
        let user: UserModel.Output
        var pagination: Pagination<[UserModel.Output]>
        
        init(user: UserModel.Output, pagination: Pagination<[UserModel.Output]>) {
            self.user = user
            self.pagination = pagination
        }
    }
    
    struct CreateView {
        let title: String = "Create Driver"
    }
}
