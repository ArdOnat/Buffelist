//
//  HomeWireFrame.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

import UIKit

class HomeWireframe {
    
    var view: HomeViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension HomeWireframe: HomeWireframeProtocol {
    
    // MARK: - Navigation
    
    func navigateToPlatform(view: HomePresenterToViewProtocol) {
        
    }
    
    func navigateToLogin(view: HomePresenterToViewProtocol) {
        if let viewController = view as? HomeViewController {
            let loginViewController = LoginModuleBuilder.createModule(parentNavigationController: viewController.navigationController!)
            viewController.navigationController?.pushViewController(loginViewController.viewControllers.first!, animated: true)
        }
    }
    
    func navigateToRegister(view: HomePresenterToViewProtocol) {
        let registerViewController = RegisterModuleBuilder.createModule()
        
        if let viewController = view as? HomeViewController {
            viewController.navigationController?.pushViewController(registerViewController.viewControllers.first!, animated: true)
        }
    }
    
}
