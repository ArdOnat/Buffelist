//
//  ProfileModuleInterface.swift
//  Buffe
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation
import UIKit
import Alamofire

//MARK: ModuleBuilder -

protocol ProfileModuleBuilderProtocol {
    func createModule() -> UINavigationController
}

//MARK: Wireframe -
protocol ProfileWireframeProtocol {
    func navigateToLogout(view: ProfilePresenterToViewProtocol)
    func navigateToLogin(view: ProfilePresenterToViewProtocol)
}

//MARK: View -
protocol ProfilePresenterToViewProtocol: class {
    var presenter: ProfileViewToPresenterProtocol?  { get set }
    
    func getFollowingsOfUser(username: String)
    func onGetFollowingsOfUserSuccess(Profile: [SearchUserResult])
    func onGetFollowingsOfUserFailure(error: String)
    
    func searchUser(username:String)
    func onSearchUserSuccess(Profile: [SearchUserResult])
    func onSearchUserFailure(error: String)
    
    func navigateToLogin()
}

protocol ProfileViewUserActionHandler {
    
}

//MARK: Presenter -
protocol ProfileViewToPresenterProtocol: class {
    var view: ProfilePresenterToViewProtocol? { get set }
    
    func getFollowingsOfUser(username: String)
    func searchUser(username: String)
    
    func logoutUser()
    
    func navigateToLogin()
}

protocol ProfileInteractorToPresenterProtocol: class {
    var interactor: ProfilePresenterToInteractorProtocol? { get set }
    
    func onGetFollowingsOfUserSuccess(Profile: [SearchUserResult])
    func onGetFollowingsOfUserFailure(error: Error)
    
    func onSearchUserSuccess(Profile: [SearchUserResult])
    func onSearchUserFailure(error: Error)
    
    func onLogoutSuccess()
    func onLogoutFailure()
    
    func navigateToLogin()
}

//MARK: Interactor -
protocol ProfilePresenterToInteractorProtocol: class {
    var presenter: ProfileInteractorToPresenterProtocol?  { get set }
    
    func sendGetFollowingsOfUserRequest(username: String)
    func onGetFollowingsOfUserSuccess(result: [SearchUserResult])
    func onGetFollowingsOfUserFailure(error: Error)
    
    func sendSearchUserRequest(username: String)
    func onSearchUserSuccess(result: [SearchUserResult])
    func onSearchUserFailure(error: Error)
    
    func logoutUser()
    func onLogoutSuccess()
    func onLogoutFailure()
}

//MARK: APIDataManager -
protocol ProfileAPIDataManagerProtocol: class {
    var interactor: ProfilePresenterToInteractorProtocol? { get set }
    
    func getFollowingsOfUserRequest(username: String)
    func searchUserRequest(username: String)
}

//MARK: LocalDataManager -
protocol ProfileLocalDataManagerProtocol: class {
    var interactor: ProfilePresenterToInteractorProtocol? { get set }
    func deleteUserData()
}

//MARK: Service -
protocol ProfileServiceProtocol {
    static func getFollowingsOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
    static func searchUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ())
}
