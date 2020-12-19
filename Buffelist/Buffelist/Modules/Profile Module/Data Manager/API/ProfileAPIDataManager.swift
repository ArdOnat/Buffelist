//
//  ProfileAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//

import Foundation

class ProfileAPIDataManager: ProfileAPIDataManagerProtocol {
    
    weak var interactor: ProfilePresenterToInteractorProtocol?
    
    init(interactor: ProfilePresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
    func getFollowingsOfUserRequest(username: String)  {
        ProfileService.getFollowingsOfUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetFollowingsOfUserSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetFollowingsOfUserFailure(error: error)
            }
        }
    }
    
    func searchUserRequest(username: String) {
        ProfileService.searchUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onSearchUserSuccess(result: result)
            case .failure(let error):
                self.interactor?.onSearchUserFailure(error: error)
            }
        }
    }

}
