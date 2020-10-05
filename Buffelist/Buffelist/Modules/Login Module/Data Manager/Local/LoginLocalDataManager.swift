//
//  LoginLocalDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 26.09.2020.
//

import Foundation

class LoginLocalDataManager: LoginLocalDataManagerProtocol {
    
    weak var interactor: LoginPresenterToInteractorProtocol?
    
    init(interactor: LoginPresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
    func createUser(result: LoginResult, password: String, token: String, completion: (()->())? = nil) {
        UserProvider.create(with: UserItem(id: result.id, username: result.username, password: password, firstName: result.firstName, lastName: result.lastName, email: result.email, profilePhotoURL: result.profilePhotoURL, biography: result.biography, token: token))
        completion!() // TODO: Change
    }
    
}
