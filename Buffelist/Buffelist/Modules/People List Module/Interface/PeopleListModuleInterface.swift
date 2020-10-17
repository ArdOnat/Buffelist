//
//  PeopleListModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation
import UIKit
import Alamofire

//MARK: ModuleBuilder -

protocol PeopleListModuleBuilderProtocol {
    func createModule(username: String) -> UINavigationController
}

//MARK: Wireframe -
protocol PeopleListWireframeProtocol {
    func navigateToUserProfile(username: String, photoURL: String, view: PeopleListPresenterToViewProtocol )
}

//MARK: View -
protocol PeopleListPresenterToViewProtocol: class {
    var presenter: PeopleListViewToPresenterProtocol?  { get set }
    
    func getFollowingsOfUser(username: String)
    func onGetFollowingsOfUserSuccess(peopleList: [SearchUserResult])
    func onGetFollowingsOfUserFailure(error: String)
    
    func searchUser(username:String)
    func onSearchUserSuccess(peopleList: [SearchUserResult])
    func onSearchUserFailure(error: String)
}

protocol PeopleListViewUserActionHandler {
    
}

//MARK: Presenter -
protocol PeopleListViewToPresenterProtocol: class {
    var view: PeopleListPresenterToViewProtocol? { get set }
    
    func getFollowingsOfUser(username: String)
    func searchUser(username: String)
    
    func navigateToUserProfile(username: String, photoURL: String)
}

protocol PeopleListInteractorToPresenterProtocol: class {
    var interactor: PeopleListPresenterToInteractorProtocol? { get set }
    
    func onGetFollowingsOfUserSuccess(peopleList: [SearchUserResult])
    func onGetFollowingsOfUserFailure(error: Error)
    
    func onSearchUserSuccess(peopleList: [SearchUserResult])
    func onSearchUserFailure(error: Error)
}

//MARK: Interactor -
protocol PeopleListPresenterToInteractorProtocol: class {
    var presenter: PeopleListInteractorToPresenterProtocol?  { get set }
    
    func sendGetFollowingsOfUserRequest(username: String)
    func onGetFollowingsOfUserSuccess(result: [SearchUserResult])
    func onGetFollowingsOfUserFailure(error: Error)
    
    func sendSearchUserRequest(username: String)
    func onSearchUserSuccess(result: [SearchUserResult])
    func onSearchUserFailure(error: Error)
}

//MARK: APIDataManager -
protocol PeopleListAPIDataManagerProtocol: class {
    var interactor: PeopleListPresenterToInteractorProtocol? { get set }
    
    func getFollowingsOfUserRequest(username: String)
    func searchUserRequest(username: String)
}

//MARK: LocalDataManager -
protocol PeopleListLocalDataManagerProtocol: class {
    var interactor: PeopleListPresenterToInteractorProtocol? { get set }
}

//MARK: Service -
protocol PeopleListServiceProtocol {
    static func getFollowingsOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
    static func searchUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
}
