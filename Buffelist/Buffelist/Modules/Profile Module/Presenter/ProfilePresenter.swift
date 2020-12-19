//
//  ProfilePresenter.swift
//  Buffe
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class ProfilePresenter {
    
    weak var view: ProfilePresenterToViewProtocol?
    var interactor: ProfilePresenterToInteractorProtocol?
    var router: ProfileWireframeProtocol?
    
    init( view: ProfilePresenterToViewProtocol, interactor: ProfilePresenterToInteractorProtocol, router: ProfileWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension ProfilePresenter: ProfileViewToPresenterProtocol {
    
    func getFollowingsOfUser(username: String) {
        interactor?.sendGetFollowingsOfUserRequest(username: username)
    }
    
    func searchUser(username: String) {
        interactor?.sendSearchUserRequest(username: username)
    }
    
    func logoutUser() {
        interactor?.logoutUser()
    }
    
    func navigateToLogin() {
        if let view = view {
            router?.navigateToLogin(view: view)
        }
    }
    
}

extension ProfilePresenter: ProfileInteractorToPresenterProtocol {
    
    // MARK: - Get Followings Of User Service
    
    func onGetFollowingsOfUserSuccess(Profile: [SearchUserResult]) {
        view?.onGetFollowingsOfUserSuccess(Profile: Profile)
    }
    
    func onGetFollowingsOfUserFailure(error: Error) {
        view?.onGetFollowingsOfUserFailure(error: error.localizedDescription)
    }
    
    // MARK: - Search User Service
    
    func onSearchUserSuccess(Profile: [SearchUserResult]) {
        view?.onSearchUserSuccess(Profile: Profile)
    }
    
    func onSearchUserFailure(error: Error) {
        view?.onSearchUserFailure(error: error.localizedDescription)
    }
    
    func onLogoutSuccess() {
        if let view = view {
            router?.navigateToLogout(view: view)
        }
        NotificationCenter.default.post(name: .didAuthenticationStatusChanged, object: nil)
    }
    
    func onLogoutFailure() {
        
    }
    
}
