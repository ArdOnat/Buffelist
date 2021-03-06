//
//  TopicListPresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class TopicListPresenter {
    
    weak var view: TopicListPresenterToViewProtocol?
    var interactor: TopicListPresenterToInteractorProtocol?
    var router: TopicListWireframeProtocol?
    
    init( view: TopicListPresenterToViewProtocol, interactor: TopicListPresenterToInteractorProtocol, router: TopicListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension TopicListPresenter: TopicListViewToPresenterProtocol {
    
    func getContentList(username: String) {
        interactor?.sendGetContentListRequest(username: username)
    }
    func getFollowersOfUser(username: String) {
        interactor?.sendGetFollowersOfUserRequest(username: username)
    }
    
    func followUser(username: String) {
        interactor?.sendFollowUserRequest(username: username)
    }
    
    func unfollowUser(username: String) {
        interactor?.sendUnfollowUserRequest(username: username)
    }
    
    func searchUserByUsername(username: String) {
        interactor?.sendSearchUserByUsernameRequest(username: username)
    }
    
    func navigateToLogin() {
        if let view = view {
            router?.navigateToLogin(view: view)
        }
    }
    
}

extension TopicListPresenter: TopicListInteractorToPresenterProtocol {
    
    // MARK: - Get Content List Service
    
    func onGetContentListSuccess(contentList: [ContentModel]) {
        view?.onGetContentListSuccess(contentList: contentList)
    }
    
    func onGetContentListFailure(error: Error) {
        view?.onGetContentListFailure(error: error.localizedDescription)
    }
    
    // MARK: - Get Followers Of User Service
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult]) {
        view?.onGetFollowersOfUserSuccess(result: result)
    }
    
    func onGetFollowersOfUserFailure(error: Error) {
        view?.onGetFollowersOfUserFailure(error: error.localizedDescription)
    }
    
    func isFollowingUser(result: [SearchUserResult]) -> Bool {
        // TODO: move to local data manager
        var isFollowing = false
        for user in result {
            if user.username == UserProvider.user().username {
                isFollowing = true
                break
            }
            else {
                isFollowing = false
            }
        }
        
        return isFollowing
    }
    
    // MARK: - Follow User Service
    
    func onFollowUserSuccess() {
        view?.onFollowUserSuccess()
    }
    
    func onFollowUserFailure(error: Error) {
        view?.onFollowUserFailure(error: error.localizedDescription)
    }
    
    // MARK: - Unfollow User Service
    
    func onUnfollowUserSuccess() {
        view?.onUnfollowUserSuccess()
    }
    
    func onUnfollowUserFailure(error: Error) {
        view?.onUnfollowUserFailure(error: error.localizedDescription)
    }
    
    // MARK: - Search User By Username Service
    
    func onSearchUserByUsernameSuccess(result: SearchUserResult) {
        if result.username == UserProvider.user().username {
            interactor?.updateUser(information: result)
        }
        
        view?.onSearchUserByUsernameSuccess(result: result)
    }
    
    func onSearchUserByUsernameFailure(error: Error) {
        view?.onSearchUserByUsernameFailure(error: error.localizedDescription)
    }
    
}
