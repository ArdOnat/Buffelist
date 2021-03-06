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
    func createModule(username: String, profilePhotoURL: String?) -> UINavigationController
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
    
    func getFollowersOfUser(username:String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: String)
    
    func followUser(username: String)
    func onFollowUserSuccess()
    func onFollowUserFailure(error: String)
    
    func unfollowUser(username: String)
    func onUnfollowUserSuccess()
    func onUnfollowUserFailure(error: String)
    
    func searchUserByUsername(username: String)
    func onSearchUserByUsernameSuccess(result: SearchUserResult)
    func onSearchUserByUsernameFailure(error: String)
}

protocol TopicListViewUserActionHandler {
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl)
    func followButtonPressed()
}

//MARK: Presenter -
protocol TopicListViewToPresenterProtocol: class {
    var view: TopicListPresenterToViewProtocol? { get set }
    
    func getContentList(username: String)
    
    func getFollowersOfUser(username: String)
    
    func followUser(username: String)
    
    func unfollowUser(username: String)
    
    func searchUserByUsername(username: String)
    
    func navigateToLogin()
}

protocol TopicListInteractorToPresenterProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: Error)
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: Error)
    
    func onFollowUserSuccess()
    func onFollowUserFailure(error: Error)
    
    func onUnfollowUserSuccess()
    func onUnfollowUserFailure(error: Error)
    
    func onSearchUserByUsernameSuccess(result: SearchUserResult)
    func onSearchUserByUsernameFailure(error: Error)
    
    func navigateToLogin()
}

//MARK: Interactor -
protocol TopicListPresenterToInteractorProtocol: class {
    var presenter: TopicListInteractorToPresenterProtocol?  { get set }
    
    func sendGetContentListRequest(username: String)
    func onGetContentListSuccess(result: GetContentListResult)
    func onGetContentListFailure(error: Error)
    
    func sendGetFollowersOfUserRequest(username: String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: Error)
    
    func sendFollowUserRequest(username: String)
    func onFollowUserSuccess()
    func onFollowUserFailure(error: Error)
    
    func sendUnfollowUserRequest(username: String)
    func onUnfollowUserSuccess()
    func onUnfollowUserFailure(error: Error)
    
    func sendSearchUserByUsernameRequest(username: String)
    func onSearchUserByUsernameSuccess(result: SearchUserResult)
    func onSearchUserByUsernameFailure(error: Error)
    
    func updateUser(information: SearchUserResult)
}

//MARK: APIDataManager -
protocol TopicListAPIDataManagerProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    
    func getContentListRequest(username: String)
    
    func getFollowersOfUserRequest(username: String)
    
    func followUserRequest(username: String)
    
    func unfollowUserRequest(username: String)
    
    func searchUserByUsernameRequest(username: String)
}

//MARK: LocalDataManager -
protocol TopicListLocalDataManagerProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    func updateUserContentListId(contentListId: Int, completion: (()->())?)
    func updateUser(information: SearchUserResult)
}

//MARK: Service -
protocol TopicListServiceProtocol {
    static func getContentList(username: String, completion: @escaping (Result<GetContentListResult, AFError>) -> ())
    static func getFollowersOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
    static func followUser(username: String, completion: @escaping (Result<Data?, AFError>) -> ())
    static func unfollowUser(username: String, completion: @escaping (Result<Data?, AFError>) -> ())
    static func searchUserByUsername(username: String,  completion: @escaping (Result<SearchUserResult, AFError>) -> ())
    
}
