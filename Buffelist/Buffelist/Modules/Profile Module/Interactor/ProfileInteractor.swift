//
//  ProfileInteractor.swift
//  Buffe
//
//  Created by Arda Onat on 3.10.2020.
//

class ProfileInteractor {

    weak var presenter: ProfileInteractorToPresenterProtocol?
    var APIDataManager: ProfileAPIDataManagerProtocol?
    var LocalDataManager: ProfileLocalDataManagerProtocol?

    init() {
        self.APIDataManager = ProfileAPIDataManager(interactor: self)
        self.LocalDataManager = ProfileLocalDataManager(interactor: self)
    }
    
}

extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
    
    // MARK: - Get Followings Of User Service
    
    func sendGetFollowingsOfUserRequest(username: String) {
        APIDataManager?.getFollowingsOfUserRequest(username: username)
    }
    
    func onGetFollowingsOfUserSuccess(result: [SearchUserResult]) {
        presenter?.onGetFollowingsOfUserSuccess(Profile: result)
    }
    
    func onGetFollowingsOfUserFailure(error: Error) {
        presenter?.onGetFollowingsOfUserFailure(error: error)
    }
    
    // MARK: - Search User Service
    
    func sendSearchUserRequest(username: String) {
        APIDataManager?.searchUserRequest(username: username)
    }
    
    func onSearchUserSuccess(result: [SearchUserResult]) {
        presenter?.onSearchUserSuccess(Profile: result)
    }
    
    func onSearchUserFailure(error: Error) {
        presenter?.onSearchUserFailure(error: error)
    }
    
    // MARK: - Logout User
    
    func logoutUser() {
        LocalDataManager?.deleteUserData()
    }
    
    func onLogoutSuccess() {
        presenter?.onLogoutSuccess()
    }
    
    func onLogoutFailure() {
        presenter?.onLogoutFailure()
    }
    
}
