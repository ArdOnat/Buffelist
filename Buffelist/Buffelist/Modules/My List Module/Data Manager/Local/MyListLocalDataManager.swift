//
//  MyListLocalDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 9.10.2020.
//

import Foundation

class MyListLocalDataManager: MyListLocalDataManagerProtocol {
    
    weak var interactor: MyListPresenterToInteractorProtocol?
    
    init(interactor: MyListPresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
    func updateUserContentListId(contentListId: Int, completion: (()->())? = nil) {
        UserProvider.updateUserContentListId(contentListId: contentListId)
        completion!() // TODO: change
    }
    
    func updateUser(information: SearchUserResult) {
        UserProvider.user().update(with: NewUserInfo(userInformation: information))
    }
    
}
