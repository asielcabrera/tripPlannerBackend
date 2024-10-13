//
//  PassangersAdminPageModel.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/10/24.
//

enum PassangersAdminPageModel {
    struct IndexView {
        let title: String = "Passanger Page"
        let user: UserModel.Output
        var pagination: Pagination<[PassangerModel.Output]>
        
        init(user: UserModel.Output, pagination: Pagination<[PassangerModel.Output]>) {
            self.user = user
            self.pagination = pagination
        }
    }
    
    struct CreateView {
        let title: String = "Create Passanger"
    }
    
    struct EditView {
        let title: String = "Edit Passanger"
        let passanger: PassangerEntity
    }
}
