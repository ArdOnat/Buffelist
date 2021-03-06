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
        
        view.parentNavigationController?.popToRootViewController(animated: true)
        /*
        let topicListModuleBuilder = TopicListModuleBuilder()
        let peopleListModuleBuilder = PeopleListModuleBuilder()
        let profileModuleBuilder = ProfileModuleBuilder()
        
        let vc1 = topicListModuleBuilder.createModule(username: "trends")
        let vc2 = topicListModuleBuilder.createModule(username: UserProvider.user().username)
        let vc3 = peopleListModuleBuilder.createModule(username: UserProvider.user().username)
        let vc4 = profileModuleBuilder.createModule()
        
        tabBarController.tabBar.tintColor = .black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .selected)

        vc1.tabBarItem = UITabBarItem(title: "Trend Contents", image: UIImage(named: "trends"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "My List", image: UIImage(named: "list"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "People", image: UIImage(named: "people"), tag: 3)
        vc4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "people"), tag: 4)
        
        tabBarController.tabBar.tintColor = .black

        tabBarController.viewControllers = [vc1, vc2, vc3, vc4]
        tabBarController.setViewControllers(tabBarController.viewControllers, animated: true)
         
        if let viewController = view as? LoginViewController {
            viewController.navigationController?
                .pushViewController(tabBarController, animated: true)
        }*/
    }
    
}
