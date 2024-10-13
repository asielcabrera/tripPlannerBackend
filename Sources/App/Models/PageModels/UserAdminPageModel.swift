//
//  UserAdminPageModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKitComponents

enum UserAdminPageModel {
    
    struct IndexView {
        let title: String = "Show users"
        let pagination: Pagination<[UserModel.Output]>
    }
    
    struct CreateView {
        let title: String = "Create user"
    }
    
    struct EditView {
        let title: String = "Edit user"
        let user: UserEntity
    }
}
