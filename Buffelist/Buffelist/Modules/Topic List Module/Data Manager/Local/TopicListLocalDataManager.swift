//
//  TopicListLocalDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 9.10.2020.
//

import Foundation

class TopicListLocalDataManager: TopicListLocalDataManagerProtocol {
    
    weak var interactor: TopicListPresenterToInteractorProtocol?
    
    init(interactor: TopicListPresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
    func updateUserContentListId(contentListId: Int, completion: (()->())? = nil) {
        UserProvider.updateUserContentListId(contentListId: contentListId)
        completion!() // TODO: change
    }
    
}
