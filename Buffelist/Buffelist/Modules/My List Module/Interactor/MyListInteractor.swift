//
//  MyListInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

class MyListInteractor {

    weak var presenter: MyListInteractorToPresenterProtocol?
    var APIDataManager: MyListAPIDataManagerProtocol?
    var LocalDataManager: MyListLocalDataManagerProtocol?
    var username: String = ""

    init() {
        self.APIDataManager = MyListAPIDataManager(interactor: self)
        self.LocalDataManager = MyListLocalDataManager(interactor: self)
    }
    
}

extension MyListInteractor: MyListPresenterToInteractorProtocol {
    
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
    
    func sendCreateContentRequest(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int) {
        APIDataManager?.createContentRequest(info: info, contentTitle: contentTitle, contentListId: contentListId)
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
    
    // MARK: - Delete Content Service
    
    func sendDeleteContentRequest(contentId: Int) {
        APIDataManager?.deleteContentRequest(contentId: contentId)
    }
    
    func onDeleteContentSuccess() {
        presenter?.onDeleteContentSuccess()
    }
    
    func onDeleteContentFailure(error: Error) {
        presenter?.onDeleteContentFailure(error: error)
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
