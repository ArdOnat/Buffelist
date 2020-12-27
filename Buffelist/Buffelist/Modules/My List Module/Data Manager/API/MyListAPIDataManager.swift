//
//  MyListAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class MyListAPIDataManager: MyListAPIDataManagerProtocol {
    
    weak var interactor: MyListPresenterToInteractorProtocol?
    
    init(interactor: MyListPresenterToInteractorProtocol) {
        self.interactor = interactor
    }

    func getContentListRequest(username: String)  {
        MyListService.getContentList(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetContentListSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetContentListFailure(error: error)
            }
        }
    }
    
    func createContentRequest(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int) {
        MyListService.createContent(info: info, contentTitle: contentTitle, contentListId: contentListId) { result in
            switch result {
            case .success(let result):
                self.interactor?.onCreateContentSuccess(result: result)
            case .failure(let error):
                self.interactor?.onCreateContentFailure(error: error)
            }
        }
    }
    
    func getInfoFromUrlRequest(url: String) {
        MyListService.getInfoFromUrl(url: url) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetInfoFromUrlSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetInfoFromUrlFailure(error: error)
            }
        }
    }
    
    func getFollowersOfUserRequest(username: String) {
        MyListService.getFollowersOfUser(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onGetFollowersOfUserSuccess(result: result)
            case .failure(let error):
                self.interactor?.onGetFollowersOfUserFailure(error: error)
            }
        }
    }
    
    func deleteContentRequest(contentId: Int) {
        MyListService.deleteContent(contentId: contentId) { result in
            switch result {
            case .success(let result):
                self.interactor?.onDeleteContentSuccess()
            case .failure(let error):
                self.interactor?.onDeleteContentFailure(error: error)
            }
        }
    }
    
    func searchUserByUsernameRequest(username: String) {
        MyListService.searchUserByUsername(username: username) { result in
            switch result {
            case .success(let result):
                self.interactor?.onSearchUserByUsernameSuccess(result: result)
            case .failure(let error):
                self.interactor?.onSearchUserByUsernameFailure(error: error)
            }
        }
    }

}
