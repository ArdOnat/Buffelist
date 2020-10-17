//
//  PeopleListModuleBuilder.swift
//  Buffelist
//
//  Created by Arda Onat on 11.10.2020.
//

import UIKit

class PeopleListModuleBuilder: PeopleListModuleBuilderProtocol {
    
    func createModule(username: String) -> UINavigationController {
        let viewController = PeopleViewController()
        let interactor = PeopleListInteractor()
        let router = PeopleListWireframe()
        
        viewController.username = username
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = PeopleListPresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
