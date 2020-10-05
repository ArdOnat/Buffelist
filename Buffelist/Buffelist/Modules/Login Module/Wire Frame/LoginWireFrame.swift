//
//  LoginWireFrame.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

import UIKit

class LoginWireframe {
    
    var view: LoginViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension LoginWireframe: LoginWireframeProtocol {
    
    // MARK: - Navigation
    
    func navigateToPeople(view: LoginPresenterToViewProtocol) {
        let tabBarController = UITabBarController()
        let topicListModuleBuilder = TopicListModuleBuilder()
        
        let vc1 = topicListModuleBuilder.createModule(username: "trends")
        let vc2 = topicListModuleBuilder.createModule(username: UserProvider.user().username)
        let vc3 = topicListModuleBuilder.createModule(username: "trends")
        
        tabBarController.tabBar.tintColor = .black

        vc1.tabBarItem = UITabBarItem(title: "Trend Contents", image: nil, tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "My List", image: nil, tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "People", image: nil, tag: 3)

        tabBarController.viewControllers = [vc1, vc2, vc3]
        tabBarController.setViewControllers(tabBarController.viewControllers, animated: true)
         
        if let viewController = view as? LoginViewController {
            viewController.navigationController?
                .pushViewController(tabBarController, animated: true)
        }
    
    }
    
}
