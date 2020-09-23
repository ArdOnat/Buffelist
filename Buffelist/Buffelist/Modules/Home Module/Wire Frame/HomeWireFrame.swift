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
        
    }
    
    func navigateToRegister(view: HomePresenterToViewProtocol) {
        
    }
    
  /*

    func pushToItemDetail(view: HomePresenterToViewProtocol) {
        let itemDetailModuleBuilder = ItemDetailModuleBuilder()
        
        let quoteDetailViewController = itemDetailModuleBuilder.createModule(item: item)
            
        let viewController = view as! SearchScreenViewController
        
        viewController.navigationController?
            .pushViewController(quoteDetailViewController.viewControllers.first!, animated: true)
    }
 */
    
}
