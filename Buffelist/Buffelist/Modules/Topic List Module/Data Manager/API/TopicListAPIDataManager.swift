//
//  TopicListAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class TopicListAPIDataManager: TopicListAPIDataManagerProtocol {
    
    weak var interactor: TopicListPresenterToInteractorProtocol?
    
    init(interactor: TopicListPresenterToInteractorProtocol) {
        self.interactor = interactor
    }

    func getContentListRequest(username: String)  {
        TopicListService.getContentList(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetContentListSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetContentListFailure(error: error)
            }
        }
    }
    
    func createContentRequest(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int) {
        TopicListService.createContent(info: info, contentTitle: contentTitle, contentListId: contentListId) { result in
            switch result {
            case .success(let result):
                self.interactor?.onCreateContentSuccess(result: result)
            case .failure(let error):
                self.interactor?.onCreateContentFailure(error: error)
            }
        }
    }
    
    func getInfoFromUrlRequest(url: String) {
        TopicListService.getInfoFromUrl(url: url) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetInfoFromUrlSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetInfoFromUrlFailure(error: error)
            }
        }
    }
    
    func getFollowersOfUserRequest(username: String) {
        TopicListService.getFollowersOfUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetFollowersOfUserSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetFollowersOfUserFailure(error: error)
            }
        }
    }
    
    func followUserRequest(username: String) {
        TopicListService.followUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onFollowUserSuccess()
            case .failure(let error):
                self.interactor?.onFollowUserFailure(error: error)
            }
        }
    }
    
    func unfollowUserRequest(username: String) {
        TopicListService.unfollowUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onUnfollowUserSuccess()
            case .failure(let error):
                self.interactor?.onUnfollowUserFailure(error: error)
            }
        }
    }
    
    func deleteContentRequest(contentId: Int) {
        TopicListService.deleteContent(contentId: contentId) { result in
            switch result {
            case .success(let result):
                self.interactor?.onDeleteContentSuccess()
            case .failure(let error):
                self.interactor?.onUnfollowUserFailure(error: error)
            }
        }
    }

}
