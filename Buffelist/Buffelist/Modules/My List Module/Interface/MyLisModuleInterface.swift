//
//  MyListModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation
import UIKit
import Alamofire

//MARK: ModuleBuilder -

protocol MyListModuleBuilderProtocol {
    func createModule(username: String, profilePhotoURL: String?) -> UINavigationController
}

//MARK: Wireframe -
protocol MyListWireframeProtocol {
    func navigateToPlatform(view: MyListPresenterToViewProtocol)
    func navigateToLogin(view: MyListPresenterToViewProtocol)
    func navigateToRegister(view: MyListPresenterToViewProtocol)
}

//MARK: View -
protocol MyListPresenterToViewProtocol: class {
    var presenter: MyListViewToPresenterProtocol?  { get set }
    
    func getContentList(username: String)
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: String)
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult)
    func onGetInfoFromUrlFailure(error: String)
    
    func createContent(info: GetInfoFromUrlResult, contentTitle: String)
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: String)
    
    func getFollowersOfUser(username:String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: String)
    
    func deleteContent(contentId: Int)
    func onDeleteContentSuccess()
    func onDeleteContentFailure(error: String)
    
    func searchUserByUsername(username: String)
    func onSearchUserByUsernameSuccess(result: SearchUserResult)
    func onSearchUserByUsernameFailure(error: String)
}

protocol MyListViewUserActionHandler {
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl)
    func addItemToListButtonPressed()
}

//MARK: Presenter -
protocol MyListViewToPresenterProtocol: class {
    var view: MyListPresenterToViewProtocol? { get set }
    
    func getContentList(username: String)
    
    func getInfoFromUrl(url: String)
    
    func createContent(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int)
    
    func getFollowersOfUser(username: String)
    
    func deleteContent(contentId: Int)
    
    func searchUserByUsername(username: String)
    
    func navigateToLogin()
}

protocol MyListInteractorToPresenterProtocol: class {
    var interactor: MyListPresenterToInteractorProtocol? { get set }
    
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: Error)
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult)
    func onGetInfoFromUrlFailure(error: Error)
    
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: Error)
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: Error)
    
    func onDeleteContentSuccess()
    func onDeleteContentFailure(error: Error)
    
    func onSearchUserByUsernameSuccess(result: SearchUserResult)
    func onSearchUserByUsernameFailure(error: Error)
    
    func navigateToLogin()
}

//MARK: Interactor -
protocol MyListPresenterToInteractorProtocol: class {
    var presenter: MyListInteractorToPresenterProtocol?  { get set }
    
    func sendGetContentListRequest(username: String)
    func onGetContentListSuccess(result: GetContentListResult)
    func onGetContentListFailure(error: Error)
    
    func sendGetInfoFromUrlRequest(url: String)
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult)
    func onGetInfoFromUrlFailure(error: Error)
    
    func sendCreateContentRequest(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int)
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: Error)
    
    func sendGetFollowersOfUserRequest(username: String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: Error)
    
    func sendDeleteContentRequest(contentId: Int)
    func onDeleteContentSuccess()
    func onDeleteContentFailure(error: Error)
    
    func sendSearchUserByUsernameRequest(username: String)
    func onSearchUserByUsernameSuccess(result: SearchUserResult)
    func onSearchUserByUsernameFailure(error: Error)
    
    func updateUser(information: SearchUserResult)
}

//MARK: APIDataManager -
protocol MyListAPIDataManagerProtocol: class {
    var interactor: MyListPresenterToInteractorProtocol? { get set }
    
    func getContentListRequest(username: String)
    
    func getInfoFromUrlRequest(url: String)
    
    func createContentRequest(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int)
    
    func getFollowersOfUserRequest(username: String)
    
    func deleteContentRequest(contentId: Int)
    
    func searchUserByUsernameRequest(username: String)
}

//MARK: LocalDataManager -
protocol MyListLocalDataManagerProtocol: class {
    var interactor: MyListPresenterToInteractorProtocol? { get set }
    func updateUserContentListId(contentListId: Int, completion: (()->())?)
    func updateUser(information: SearchUserResult)
}

//MARK: Service -
protocol MyListServiceProtocol {
    static func getContentList(username: String, completion: @escaping (Result<GetContentListResult, AFError>) -> ())
    static func getInfoFromUrl(url: String, completion: @escaping (Result<GetInfoFromUrlResult, AFError>) -> ())
    static func createContent(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int, completion: @escaping (Result<CreateContentResult, AFError>) -> ())
    static func getFollowersOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
    static func deleteContent(contentId: Int, completion: @escaping (Result<Data?, AFError>) -> ())
    static func searchUserByUsername(username: String,  completion: @escaping (Result<SearchUserResult, AFError>) -> ())
    
}
