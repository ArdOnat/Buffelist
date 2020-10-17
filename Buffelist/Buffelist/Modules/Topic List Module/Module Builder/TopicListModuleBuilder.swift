//
//  TopicListModuleBuilder.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

class TopicListModuleBuilder: TopicListModuleBuilderProtocol {
    
    func createModule(username: String, profilePhotoURL: String? = nil) -> UINavigationController {
        let viewController = TopicListViewController()
        let interactor = TopicListInteractor()
        let router = TopicListWireframe()
        
        viewController.username = username
        
        if let url = profilePhotoURL {
            viewController.profilePhotoURL = url
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = TopicListPresenter(view: viewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}
