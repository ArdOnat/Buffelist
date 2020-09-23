//
//  HomeModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

import UIKit

//MARK: ModuleBuilder -

protocol HomeModuleBuilderProtocol {
    func createModule() -> UINavigationController
}

//MARK: Wireframe -
protocol HomeWireframeProtocol {
    func navigateToPlatform(view: HomePresenterToViewProtocol)
    func navigateToLogin(view: HomePresenterToViewProtocol)
    func navigateToRegister(view: HomePresenterToViewProtocol)
}

//MARK: View -
protocol HomePresenterToViewProtocol: class {
    var presenter: HomeViewToPresenterProtocol?  { get set }
}

protocol HomeViewUserActionHandler {
    func platformButtonPressed()
    func loginButtonPressed()
    func registerButtonPressed()
}

//MARK: Presenter -
protocol HomeViewToPresenterProtocol: class {
    var view: HomePresenterToViewProtocol? { get set }
    func navigateToPlatform()
    func navigateToLogin()
    func navigateToRegister()
}

protocol HomeInteractorToPresenterProtocol: class {
    var interactor: HomePresenterToInteractorProtocol? { get set }
}

//MARK: Interactor -
protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol?  { get set }
}

//MARK: APIDataManager -
protocol HomeAPIDataManagerProtocol: class {
    var interactor: HomePresenterToInteractorProtocol? { get set }
}

//MARK: Service -
protocol HomeServiceProtocol {

}
