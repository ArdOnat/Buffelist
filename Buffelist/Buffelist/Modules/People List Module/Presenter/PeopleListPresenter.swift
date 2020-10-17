//
//  PeopleListPresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class PeopleListPresenter {
    
    weak var view: PeopleListPresenterToViewProtocol?
    var interactor: PeopleListPresenterToInteractorProtocol?
    var router: PeopleListWireframeProtocol?
    
    init( view: PeopleListPresenterToViewProtocol, interactor: PeopleListPresenterToInteractorProtocol, router: PeopleListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension PeopleListPresenter: PeopleListViewToPresenterProtocol {
    
    func getFollowingsOfUser(username: String) {
        interactor?.sendGetFollowingsOfUserRequest(username: username)
    }
    
    func searchUser(username: String) {
        interactor?.sendSearchUserRequest(username: username)
    }
    
}

extension PeopleListPresenter: PeopleListInteractorToPresenterProtocol {
    
    // MARK: - Get Followings Of User Service
    
    func onGetFollowingsOfUserSuccess(peopleList: [SearchUserResult]) {
        view?.onGetFollowingsOfUserSuccess(peopleList: peopleList)
    }
    
    func onGetFollowingsOfUserFailure(error: Error) {
        view?.onGetFollowingsOfUserFailure(error: error.localizedDescription)
    }
    
    // MARK: - Search User Service
    
    func onSearchUserSuccess(peopleList: [SearchUserResult]) {
        view?.onSearchUserSuccess(peopleList: peopleList)
    }
    
    func onSearchUserFailure(error: Error) {
        view?.onSearchUserFailure(error: error.localizedDescription)
    }
    
}

extension PeopleListPresenter {
    
    func navigateToUserProfile(username: String, photoURL: String) {
        
        if let view = view {
            router?.navigateToUserProfile(username: username, photoURL: photoURL, view: view)
        }
    }
    
}
