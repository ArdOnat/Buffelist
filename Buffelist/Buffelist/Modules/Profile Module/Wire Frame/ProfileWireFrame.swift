//
//  ProfileWireFrame.swift
//  Buffe
//
//  Created by Arda Onat on 24.10.2020.
//

import Foundation
import UIKit

class ProfileWireframe {
    
    var view: ProfileViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension ProfileWireframe: ProfileWireframeProtocol {
    
    func navigateToLogout(view: ProfilePresenterToViewProtocol) {
        
        if let viewController = view as? ProfileViewController {
            viewController.tabBarController?.selectedIndex = 0
        }
    }
    
    func navigateToLogin(view: ProfilePresenterToViewProtocol) {
        if let viewController = view as? ProfileViewController {
            let loginViewController = LoginModuleBuilder.createModule(parentNavigationController: viewController.navigationController!)
            viewController.navigationController?.pushViewController(loginViewController.viewControllers.first!, animated: true)
        }
    }
    
}
