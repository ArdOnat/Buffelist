//
//  ProfileModuleBuilder.swift
//  Buffe
//
//  Created by Arda Onat on 24.10.2020.
//

import UIKit

class ProfileModuleBuilder: ProfileModuleBuilderProtocol {
    
    func createModule() -> UINavigationController {
        let viewController = ProfileViewController()
        let interactor = ProfileInteractor()
        let router = ProfileWireframe()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = ProfilePresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
