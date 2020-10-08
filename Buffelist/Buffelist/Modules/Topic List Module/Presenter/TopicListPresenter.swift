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
    
    func getInfoFromUrl(url: String) {
        interactor?.sendGetInfoFromUrlRequest(url: url)
    }
    
    func createContent(info: GetInfoFromUrlResult, contentListId: Int) {
        interactor?.sendCreateContentRequest(info: info, contentListId: contentListId)
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
    
}

extension TopicListPresenter: TopicListInteractorToPresenterProtocol {
    
    // MARK: - Get Content List Service
    
    func onGetContentListSuccess(contentList: [ContentModel], contentListId: Int) {
        view?.onGetContentListSuccess(contentList: contentList, contentListId: contentListId)
    }
    
    func onGetContentListFailure(error: Error) {
        view?.onGetContentListFailure(error: error.localizedDescription)
    }
    
    // MARK: - Get Info From Url Service
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult) {
        view?.onGetInfoFromUrlSuccess(result: result)
        //createContent(info: result)
    }
    
    func onGetInfoFromUrlFailure(error: Error) {
        view?.onGetInfoFromUrlFailure(error: error.localizedDescription)
    }
    
    // MARK: - Create Content Service
    
    func onCreateContentSuccess(result: CreateContentResult) {
        view?.onCreateContentSuccess(result: result)
    }
    
    func onCreateContentFailure(error: Error) {
        view?.onCreateContentFailure(error: error.localizedDescription)
    }
    
    // MARK: - Get Followers Of User Service
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult]) {
        view?.onGetFollowersOfUserSuccess(result: result, isFollowing: isFollowingUser(result: result))
        
    }
    
    func onGetFollowersOfUserFailure(error: Error) {
        view?.onGetFollowersOfUserFailure(error: error.localizedDescription)
    }
    
    func isFollowingUser(result: [SearchUserResult]) -> Bool {
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
    
}
