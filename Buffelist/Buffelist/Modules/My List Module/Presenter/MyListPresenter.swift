//
//  MyListPresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class MyListPresenter {
    
    weak var view: MyListPresenterToViewProtocol?
    var interactor: MyListPresenterToInteractorProtocol?
    var router: MyListWireframeProtocol?
    
    init( view: MyListPresenterToViewProtocol, interactor: MyListPresenterToInteractorProtocol, router: MyListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension MyListPresenter: MyListViewToPresenterProtocol {
    
    func getContentList(username: String) {
        interactor?.sendGetContentListRequest(username: username)
    }
    
    func getInfoFromUrl(url: String) {
        interactor?.sendGetInfoFromUrlRequest(url: url)
    }
    
    func createContent(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int) {
        interactor?.sendCreateContentRequest(info: info, contentTitle: contentTitle, contentListId: contentListId)
    }
    
    func getFollowersOfUser(username: String) {
        interactor?.sendGetFollowersOfUserRequest(username: username)
    }
    
    func deleteContent(contentId: Int) {
        interactor?.sendDeleteContentRequest(contentId: contentId)
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

extension MyListPresenter: MyListInteractorToPresenterProtocol {
    
    // MARK: - Get Content List Service
    
    func onGetContentListSuccess(contentList: [ContentModel]) {
        view?.onGetContentListSuccess(contentList: contentList)
    }
    
    func onGetContentListFailure(error: Error) {
        view?.onGetContentListFailure(error: error.localizedDescription)
    }
    
    // MARK: - Get Info From Url Service
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult) {
        view?.onGetInfoFromUrlSuccess(result: result)
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
    
    // MARK: - Delete Content Service
    
    func onDeleteContentSuccess() {
        view?.onDeleteContentSuccess()
    }
    
    func onDeleteContentFailure(error: Error) {
        view?.onDeleteContentFailure(error: error.localizedDescription)
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
