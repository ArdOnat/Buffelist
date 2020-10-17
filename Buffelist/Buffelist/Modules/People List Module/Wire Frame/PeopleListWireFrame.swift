//
//  PeopleListWireFrame.swift
//  Buffelist
//
//  Created by Arda Onat on 11.10.2020.
//

import Foundation

import UIKit

class PeopleListWireframe {
    
    var view: PeopleViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension PeopleListWireframe: PeopleListWireframeProtocol {
    
    func navigateToUserProfile(username: String, photoURL: String, view: PeopleListPresenterToViewProtocol) {
        
        let topicListModuleBuilder = TopicListModuleBuilder()
        let vc1 = topicListModuleBuilder.createModule(username: username, profilePhotoURL: photoURL)
        
        if let viewController = view as? PeopleViewController {
            viewController.navigationController?.pushViewController(vc1.viewControllers.first!, animated: true)
        }
        
    }
    
}
