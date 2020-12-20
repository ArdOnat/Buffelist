//
//  MyListModuleBuilder.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

class MyListModuleBuilder: MyListModuleBuilderProtocol {
    
    func createModule(username: String, profilePhotoURL: String? = nil) -> UINavigationController {
        let viewController = MyListViewController()
        let interactor = MyListInteractor()
        let router = MyListWireframe()
        
        viewController.username = username
        
        if let url = profilePhotoURL {
            viewController.profilePhotoURL = url
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = MyListPresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
