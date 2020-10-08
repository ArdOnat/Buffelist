//
//  UserProvider.swift
//  Covid19Tracker
//
//  Created by ArdOnatAdmin on 17.09.2020.
//  Copyright © 2020 ArdOnatAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class UserProvider {
    
    private static let adapter = RealmObjectAdapter<UserModel>()
    
    static func users() -> [UserItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func user() -> UserModel {
        print(adapter.objects())
        if let user = adapter.objects()?.first {
            return user
        }
        
        do {
            return try createModel()
        } catch let error {
            fatalError("\(error as NSError)")
        }
    }
    
    private static func createModel() throws -> UserModel {
        try removeAll()
        return try adapter.create()
    }
    
    @discardableResult static func create(with user: UserItem, completion: (()->())? = nil) -> UserItem {
        guard let model = try? adapter.create(["id": user.id, "username": user.username, "password": user.password, "firstName": user.firstName, "lastName": user.lastName, "email": user.email, "profilePhotoURL": user.profilePhotoURL, "biography": user.biography, "token": user.token], completion: completion) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func remove(user: UserItem) {
        guard let model = userModel(for: user.id) else { return }
        try? RealmService.remove(model)
    }
    
    static func removeAll() throws {
        try RealmService.removeAll(of: UserModel.self)
    }

}

private extension UserProvider {
    
    static func userModel(for identifier: Int) -> UserModel? {
        return adapter.objects()?.filter("\(#keyPath(UserModel.id)) == '\(identifier)'").first
    }
    
}

extension UserProvider {
    
    static func updateUserContentListId(contentListId: Int) {
        user().contentListId = contentListId
    }
}
