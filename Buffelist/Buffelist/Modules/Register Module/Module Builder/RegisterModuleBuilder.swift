//
//  RegisterModuleBuilder.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

import UIKit

class RegisterModuleBuilder: RegisterModuleBuilderProtocol {
    
    static func createModule() -> UINavigationController {
        let viewController = RegisterViewController()
        let interactor = RegisterInteractor()
        let router = RegisterWireframe()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = RegisterPresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
