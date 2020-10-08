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
    
    func createContent(info: GetInfoFromUrlResult)
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: String)
    
    func getFollowersOfUser(username:String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult], isFollowing: Bool)
    func onGetFollowersOfUserFailure(error: String)
}

protocol TopicListViewUserActionHandler {
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl)
}

//MARK: Presenter -
protocol TopicListViewToPresenterProtocol: class {
    var view: TopicListPresenterToViewProtocol? { get set }
    
    func getContentList(username: String)
    
    func getInfoFromUrl(url: String)
    
    func createContent(info: GetInfoFromUrlResult)
    
    func getFollowersOfUser(username: String)
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
    
    func sendCreateContentRequest(info: GetInfoFromUrlResult)
    func onCreateContentSuccess(result: CreateContentResult)
    func onCreateContentFailure(error: Error)
    
    func sendGetFollowersOfUserRequest(username: String)
    func onGetFollowersOfUserSuccess(result: [SearchUserResult])
    func onGetFollowersOfUserFailure(error: Error)
}

//MARK: APIDataManager -
protocol TopicListAPIDataManagerProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    
    func getContentListRequest(username: String)
    
    func getInfoFromUrlRequest(url: String)
    
    func createContentRequest(info: GetInfoFromUrlResult)
    
    func getFollowersOfUserRequest(username: String)
}

//MARK: Service -
protocol TopicListServiceProtocol {
    static func getContentList(username: String, completion: @escaping (Result<GetContentListResult, AFError>) -> ())
    static func getInfoFromUrl(url: String, completion: @escaping (Result<GetInfoFromUrlResult, AFError>) -> ())
    static func createContent(info: GetInfoFromUrlResult, completion: @escaping (Result<CreateContentResult, AFError>) -> ())
    static func getFollowersOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
}
