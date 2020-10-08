//
//  TopicListInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

class TopicListInteractor {

    weak var presenter: TopicListInteractorToPresenterProtocol?
    var APIDataManager: TopicListAPIDataManagerProtocol?
    //var LocalDataManager: TopicListLocalDataManagerProtocol?

    init() {
        self.APIDataManager = TopicListAPIDataManager(interactor: self)
        //self.LocalDataManager = TopicListLocalDataManager(interactor: self)
    }
    
}

extension TopicListInteractor: TopicListPresenterToInteractorProtocol {
    
    // MARK: - Get Content List Service
    
    func sendGetContentListRequest(username: String) {
        APIDataManager?.getContentListRequest(username: username)
    }
    
    func onGetContentListSuccess(result: GetContentListResult) {
        let contentList = result.contents.map { ContentModel(fromContentInformation: $0)}.reversed() as [ContentModel]
        let contentListId = result.id
        presenter?.onGetContentListSuccess(contentList: contentList, contentListId: contentListId)
    }
    
    func onGetContentListFailure(error: Error) {
        presenter?.onGetContentListFailure(error: error)
    }
    
    // MARK: - Get Info From Url Service
    
    func sendGetInfoFromUrlRequest(url: String) {
        APIDataManager?.getInfoFromUrlRequest(url: url)
    }
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult) {
        presenter?.onGetInfoFromUrlSuccess(result: result)
    }
    
    func onGetInfoFromUrlFailure(error: Error) {
        presenter?.onGetInfoFromUrlFailure(error: error)
    }
    
    // MARK: - Create Content Service
    
    func sendCreateContentRequest(info: GetInfoFromUrlResult, contentListId: Int) {
        APIDataManager?.createContentRequest(info: info, contentListId: contentListId)
    }
    
    func onCreateContentSuccess(result: CreateContentResult) {
        presenter?.onCreateContentSuccess(result: result)
    }
    
    func onCreateContentFailure(error: Error) {
        presenter?.onCreateContentFailure(error: error)
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
    
    
}
