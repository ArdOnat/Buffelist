//
//  TopicListWireFrame.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

class TopicListWireframe {
    
    var view: TopicListViewController!
    var navigationController: UINavigationController?
    
}

// MARK: SearchScreenWireframeProtocol
extension TopicListWireframe: TopicListWireframeProtocol {
    
    func navigateToPlatform(view: TopicListPresenterToViewProtocol) {
        
    }
    
    func navigateToLogin(view: TopicListPresenterToViewProtocol) {
        
    }
    
    func navigateToRegister(view: TopicListPresenterToViewProtocol) {
        
    }
    
}
