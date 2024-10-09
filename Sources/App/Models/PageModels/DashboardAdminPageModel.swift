//
//  DashboardAdminPageModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

enum  DashboardAdminPageModel {
    struct IndexView {
        let title: String = "Dashboard"
        let user: UserModel.Output
        
        init(user: UserModel.Output) {
            self.user = user
        }
    }
}
