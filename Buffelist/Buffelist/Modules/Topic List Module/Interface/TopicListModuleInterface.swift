//
//  TopicListModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation
import UIKit
import Alamofire

//MARK: ModuleBuilder -

protocol TopicListModuleBuilderProtocol {
    func createModule(username: String) -> UINavigationController
}

//MARK: Wireframe -
protocol TopicListWireframeProtocol {
    func navigateToPlatform(view: TopicListPresenterToViewProtocol)
    func navigateToLogin(view: TopicListPresenterToViewProtocol)
    func navigateToRegister(view: TopicListPresenterToViewProtocol)
}

//MARK: View -
protocol TopicListPresenterToViewProtocol: class {
    var presenter: TopicListViewToPresenterProtocol?  { get set }
    
    func getContentList(username: String)
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: String)
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult)
    func onGetInfoFromUrlFailure(error: String)
    
    func createContent(info: GetInfoFromUrlResult, contentTitle: String)
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: String)
    
    func getFollowersOfUser(username:String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult], isFollowing: Bool)
    func onGetFollowersOfUserFailure(error: String)
    
    func followUser(username: String)
    func onFollowUserSuccess()
    func onFollowUserFailure(error: String)
    
    func unfollowUser(username: String)
    func onUnfollowUserSuccess()
    func onUnfollowUserFailure(error: String)
    
    func deleteContent(contentId: Int)
    func onDeleteContentSuccess()
    func onDeleteContentFailure(error: String)
}

protocol TopicListViewUserActionHandler {
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl)
    func addItemToListButtonPressed()
    func followButtonPressed()
}

//MARK: Presenter -
protocol TopicListViewToPresenterProtocol: class {
    var view: TopicListPresenterToViewProtocol? { get set }
    
    func getContentList(username: String)
    
    func getInfoFromUrl(url: String)
    
    func createContent(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int)
    
    func getFollowersOfUser(username: String)
    
    func followUser(username: String)
    
    func unfollowUser(username: String)
    
    func deleteContent(contentId: Int)
}

protocol TopicListInteractorToPresenterProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: Error)
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult)
    func onGetInfoFromUrlFailure(error: Error)
    
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: Error)
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: Error)
    
    func onFollowUserSuccess()
    func onFollowUserFailure(error: Error)
    
    func onUnfollowUserSuccess()
    func onUnfollowUserFailure(error: Error)
    
    func onDeleteContentSuccess()
    func onDeleteContentFailure(error: Error)
}

//MARK: Interactor -
protocol TopicListPresenterToInteractorProtocol: class {
    var presenter: TopicListInteractorToPresenterProtocol?  { get set }
    
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
    
    func sendFollowUserRequest(username: String)
    func onFollowUserSuccess()
    func onFollowUserFailure(error: Error)
    
    func sendUnfollowUserRequest(username: String)
    func onUnfollowUserSuccess()
    func onUnfollowUserFailure(error: Error)
    
    func sendDeleteContentRequest(contentId: Int)
    func onDeleteContentSuccess()
    func onDeleteContentFailure(error: Error)
}

//MARK: APIDataManager -
protocol TopicListAPIDataManagerProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    
    func getContentListRequest(username: String)
    
    func getInfoFromUrlRequest(url: String)
    
    func createContentRequest(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int)
    
    func getFollowersOfUserRequest(username: String)
    
    func followUserRequest(username: String)
    
    func unfollowUserRequest(username: String)
    
    func deleteContentRequest(contentId: Int)
}

//MARK: LocalDataManager -
protocol TopicListLocalDataManagerProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    func updateUserContentListId(contentListId: Int, completion: (()->())?)
}

//MARK: Service -
protocol TopicListServiceProtocol {
    static func getContentList(username: String, completion: @escaping (Result<GetContentListResult, AFError>) -> ())
    static func getInfoFromUrl(url: String, completion: @escaping (Result<GetInfoFromUrlResult, AFError>) -> ())
    static func createContent(info: GetInfoFromUrlResult, contentTitle: String, contentListId: Int, completion: @escaping (Result<CreateContentResult, AFError>) -> ())
    static func getFollowersOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
    static func followUser(username: String, completion: @escaping (Result<Data?, AFError>) -> ())
    static func unfollowUser(username: String, completion: @escaping (Result<Data?, AFError>) -> ())
    static func deleteContent(contentId: Int, completion: @escaping (Result<Data?, AFError>) -> ())
}
