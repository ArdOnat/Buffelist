//
//  HomeModuleBuilder.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

import UIKit

class HomeModuleBuilder: HomeModuleBuilderProtocol {
    
    func createModule() -> UINavigationController {
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeWireframe()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = HomePresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
