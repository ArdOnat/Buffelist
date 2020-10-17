//
//  PeopleListInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

class PeopleListInteractor {

    weak var presenter: PeopleListInteractorToPresenterProtocol?
    var APIDataManager: PeopleListAPIDataManagerProtocol?
    //var LocalDataManager: PeopleListLocalDataManagerProtocol?

    init() {
        self.APIDataManager = PeopleListAPIDataManager(interactor: self)
        //self.LocalDataManager = PeopleListLocalDataManager(interactor: self)
    }
    
}

extension PeopleListInteractor: PeopleListPresenterToInteractorProtocol {
    
    // MARK: - Get Followings Of User Service
    
    func sendGetFollowingsOfUserRequest(username: String) {
        APIDataManager?.getFollowingsOfUserRequest(username: username)
    }
    
    func onGetFollowingsOfUserSuccess(result: [SearchUserResult]) {
        presenter?.onGetFollowingsOfUserSuccess(peopleList: result)
    }
    
    func onGetFollowingsOfUserFailure(error: Error) {
        presenter?.onGetFollowingsOfUserFailure(error: error)
    }
    
    // MARK: - Search User Service
    
    func sendSearchUserRequest(username: String) {
        APIDataManager?.searchUserRequest(username: username)
    }
    
    func onSearchUserSuccess(result: [SearchUserResult]) {
        presenter?.onSearchUserSuccess(peopleList: result)
    }
    
    func onSearchUserFailure(error: Error) {
        presenter?.onSearchUserFailure(error: error)
    }
    
}
