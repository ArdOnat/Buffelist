//
//  RegisterModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

import UIKit
import Alamofire

//MARK: ModuleBuilder -

protocol RegisterModuleBuilderProtocol {
    static func createModule() -> UINavigationController
}

//MARK: Wireframe -
protocol RegisterWireframeProtocol {
    func navigateToPeople(view: RegisterPresenterToViewProtocol)
}

//MARK: View -
protocol RegisterPresenterToViewProtocol: class {
    var presenter: RegisterViewToPresenterProtocol?  { get set }
}

protocol RegisterViewUserActionHandler {
    func continueButtonPressed()
}

//MARK: Presenter -
protocol RegisterViewToPresenterProtocol: class {
    var view: RegisterPresenterToViewProtocol? { get set }
    func register(username: String, email: String, password: String)
}

protocol RegisterInteractorToPresenterProtocol: class {
    var interactor: RegisterPresenterToInteractorProtocol? { get set }
    func onRegisterSuccess()
    func onRequestFailure(error: Error)
}

//MARK: Interactor -
protocol RegisterPresenterToInteractorProtocol: class {
    var presenter: RegisterInteractorToPresenterProtocol?  { get set }
    func sendRegisterRequest(username: String, email: String, password: String)
    func onRegisterSuccess()
    func onRequestFailure(error: Error)
}

//MARK: APIDataManager -
protocol RegisterAPIDataManagerProtocol: class {
    var interactor: RegisterPresenterToInteractorProtocol? { get set }
    func sendRegisterRequest(username: String, email: String, password: String)
}

//MARK: Service -
protocol RegisterServiceProtocol {
    static func register(username: String, email: String, password: String, completion: @escaping (Result<Data?, AFError>) -> ())
}
