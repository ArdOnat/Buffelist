//
//  RegisterWireFrame.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//


import UIKit

class RegisterWireframe {
    
    var view: RegisterViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension RegisterWireframe: RegisterWireframeProtocol {
    
    // MARK: - Navigation
    
    func navigateToPeople(view: RegisterPresenterToViewProtocol) {
       
        /*
        let tabBarController = UITabBarController()
        let peopleModuleBuilder = PeopleModuleBuilder()
        let myListModuleBuilder = MyListModuleBuilder()
        let profileModuleBuilder = ProfileModuleBuilder()
        
        let vc1 = peopleModuleBuilder.createModule()
        let vc2 = myListModuleBuilder.createModule()
        let vc3 = profileModuleBuilder.createModule()

        vc1.tabBarItem = UITabBarItem(title: ConstantStrings.firstTabTitle, image: UIImage(named: ConstantStrings.taxi), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: ConstantStrings.map, image: UIImage(named: ConstantStrings.map), tag: 2)

        tabBarController.viewControllers = [vc1, vc2]
        tabBarController.setViewControllers(tabBarController.viewControllers, animated: true)
         
         viewController.navigationController?
             .pushViewController(tabBarController, animated: true)
         
         */
        
        
    }
    
}
