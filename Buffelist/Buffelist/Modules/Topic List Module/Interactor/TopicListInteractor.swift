//
//  TopicListInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

class TopicListInteractor {

    weak var presenter: TopicListInteractorToPresenterProtocol?
    var APIDataManager: TopicListAPIDataManagerProtocol?
    var LocalDataManager: TopicListLocalDataManagerProtocol?
    var username: String = ""

    init() {
        self.APIDataManager = TopicListAPIDataManager(interactor: self)
        self.LocalDataManager = TopicListLocalDataManager(interactor: self)
    }
    
}

extension TopicListInteractor: TopicListPresenterToInteractorProtocol {
    
    // MARK: - Get Content List Service
    
    func sendGetContentListRequest(username: String) {
        self.username = username
        APIDataManager?.getContentListRequest(username: username)
    }
    
    func onGetContentListSuccess(result: GetContentListResult) {
        let contentList = result.contents.map { ContentModel(fromContentInformation: $0)}.reversed() as [ContentModel]
        let contentListId = result.id
        
        if UserProvider.users().count != 0 {
            if username == UserProvider.user().username {
                LocalDataManager?.updateUserContentListId(contentListId: contentListId) {
                    self.presenter?.onGetContentListSuccess(contentList: contentList)
                }
            }
            else {
                self.presenter?.onGetContentListSuccess(contentList: contentList)
            }
        }
        else {
            self.presenter?.onGetContentListSuccess(contentList: contentList)
        }
    }
    
    func onGetContentListFailure(error: Error) {
        presenter?.onGetContentListFailure(error: error)
    }
    
    // MARK: - Get Followers Of User Service
    
    func sendGetFollowersOfUserRequest(username: String) {
        APIDataManager?.getFollowersOfUserRequest(username: username)
    }
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult]) {
        presenter?.onGetFollowersOfUserSuccess(result: result)
    }
    
    func onGetFollowersOfUserFailure(error: Error) {
        presenter?.onGetFollowersOfUserFailure(error: error)
    }
    
    // MARK: - Follow User Service
    
    func sendFollowUserRequest(username: String) {
        APIDataManager?.followUserRequest(username: username)
    }
    
    func onFollowUserSuccess() {
        presenter?.onFollowUserSuccess()
    }
    
    func onFollowUserFailure(error: Error) {
        presenter?.onFollowUserFailure(error: error)
    }
    
    // MARK: - Unfollow User Service
    
    func sendUnfollowUserRequest(username: String) {
        APIDataManager?.unfollowUserRequest(username: username)
    }
    
    func onUnfollowUserSuccess() {
        presenter?.onUnfollowUserSuccess()
    }
    
    func onUnfollowUserFailure(error: Error) {
        presenter?.onUnfollowUserFailure(error: error)
    }
    
    // MARK: - Search User By Username Service
    
    func sendSearchUserByUsernameRequest(username: String) {
        self.username = username
        APIDataManager?.searchUserByUsernameRequest(username: username)
    }
    
    func onSearchUserByUsernameSuccess(result: SearchUserResult) {
        presenter?.onSearchUserByUsernameSuccess(result: result)
    }
    
    func onSearchUserByUsernameFailure(error: Error) {
        presenter?.onSearchUserByUsernameFailure(error: error)
    }
    
    func updateUser(information: SearchUserResult) {
        LocalDataManager?.updateUser(information: information)
    }
    
}
