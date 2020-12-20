//
//  MyListWireFrame.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

class MyListWireframe {
    
    var view: MyListViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension MyListWireframe: MyListWireframeProtocol {
    
    func navigateToPlatform(view: MyListPresenterToViewProtocol) {
        
    }
    
    func navigateToLogin(view: MyListPresenterToViewProtocol) {
        if let viewController = view as? MyListViewController {
            let loginViewController = LoginModuleBuilder.createModule(parentNavigationController: viewController.navigationController!)
            viewController.navigationController?.pushViewController(loginViewController.viewControllers.first!, animated: true)
        }
    }
    
    func navigateToRegister(view: MyListPresenterToViewProtocol) {
        
    }
    
}
