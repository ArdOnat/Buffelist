//
//  UserModel.swift
//  Covid19Tracker
//
//  Created by ArdOnatAdmin on 17.09.2020.
//  Copyright © 2020 ArdOnatAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var profilePhotoURL = ""
    @objc dynamic var biography = ""
    @objc dynamic var token = ""
    @objc dynamic var contentListId = 0
    
    func update(with user: NewUserInfo) {
        try? RealmService.write {
            id = user.id
            username = user.username
            password = user.password
            firstName = user.firstName
            lastName = user.lastName
            email = user.email
            profilePhotoURL = user.profilePhotoURL
            biography = user.biography
            token = user.token
            contentListId = user.contentListId
        }
    }

}

extension UserModel {
    
    var toItem: UserItem {
        return UserItem(with: self)
    }
    
}

extension UserItem {
    
    init(with userModel: UserModel) {
        id = userModel.id
        username = userModel.username
        password = userModel.password
        firstName = userModel.firstName
        lastName = userModel.lastName
        email = userModel.email
        profilePhotoURL = userModel.profilePhotoURL
        biography = userModel.biography
        token = userModel.token
        contentListId = userModel.contentListId
    }
    
}

struct NewUserInfo {
    var id: Int
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var email: String
    var profilePhotoURL: String
    var biography: String
    var token: String
    var contentListId: Int
    
    init(userInformation: SearchUserResult) {
        self.id = userInformation.id
        self.password = UserProvider.user().password
        self.username = userInformation.username
        self.firstName = userInformation.firstName ?? ""
        self.lastName = userInformation.lastName ?? ""
        self.email = userInformation.email ?? ""
        self.profilePhotoURL = userInformation.profilePhotoURL ?? ""
        self.biography = userInformation.biography ?? ""
        self.token = UserProvider.user().token
        self.contentListId = UserProvider.user().contentListId
    }
}
