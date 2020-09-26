//
//  LoginModuleBuilder.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

import UIKit

class LoginModuleBuilder: LoginModuleBuilderProtocol {
    
    static func createModule() -> UINavigationController {
        let viewController = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginWireframe()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = LoginPresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
