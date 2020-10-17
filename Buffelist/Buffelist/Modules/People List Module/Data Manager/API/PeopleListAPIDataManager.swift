//
//  PeopleListAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 11.10.2020.
//

import Foundation

class PeopleListAPIDataManager: PeopleListAPIDataManagerProtocol {
    
    weak var interactor: PeopleListPresenterToInteractorProtocol?
    
    init(interactor: PeopleListPresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
    func getFollowingsOfUserRequest(username: String)  {
        PeopleListService.getFollowingsOfUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetFollowingsOfUserSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetFollowingsOfUserFailure(error: error)
            }
        }
    }
    
    func searchUserRequest(username: String) {
        PeopleListService.searchUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onSearchUserSuccess(result: result)
            case .failure(let error):
                self.interactor?.onSearchUserFailure(error: error)
            }
        }
    }

}
