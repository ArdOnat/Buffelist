//
//  LoginModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

import UIKit
import Alamofire

//MARK: ModuleBuilder -

protocol LoginModuleBuilderProtocol {
    static func createModule() -> UINavigationController
}

//MARK: Wireframe -
protocol LoginWireframeProtocol {
    func navigateToPeople(view: LoginPresenterToViewProtocol)
}

//MARK: View -
protocol LoginPresenterToViewProtocol: class {
    var presenter: LoginViewToPresenterProtocol?  { get set }
}

protocol LoginViewUserActionHandler {
    func forgotPasswordButtonPressed()
    func loginButtonPressed()
}

//MARK: Presenter -
protocol LoginViewToPresenterProtocol: class {
    var view: LoginPresenterToViewProtocol? { get set }
    func login(userInfo: String, password: String)
    func getResetLink(userInfo: String)
}

protocol LoginInteractorToPresenterProtocol: class {
    var interactor: LoginPresenterToInteractorProtocol? { get set }
    func onLoginSuccess()
    func onRequestFailure(error: Error)
}

//MARK: Interactor -
protocol LoginPresenterToInteractorProtocol: class {
    var presenter: LoginInteractorToPresenterProtocol?  { get set }
    func sendLoginRequest(userInfo: String, password: String)
    func sendGetResetLinkRequest(userInfo: String)
    func onLoginSuccess(result: LoginResult, token: String, password: String)
    func onRequestFailure(error: Error)
}

//MARK: APIDataManager -
protocol LoginAPIDataManagerProtocol: class {
    var interactor: LoginPresenterToInteractorProtocol? { get set }
    func sendLoginRequest(userInfo: String, password: String)
    func sendGetResetLinkRequest(userInfo: String)
}

//MARK: LocalDataManager -
protocol LoginLocalDataManagerProtocol: class {
    var interactor: LoginPresenterToInteractorProtocol? { get set }
    func createUser(result: LoginResult, password: String, token: String, completion: (()->())?)
}

//MARK: Service -
protocol LoginServiceProtocol {
    static func login(userInfo: String, password: String, completion: @escaping (Result<LoginResult, AFError>, String) -> ())
    static func getResetLink(userInfo: String, completion: @escaping (Result<Data?, AFError>) -> ())
}
