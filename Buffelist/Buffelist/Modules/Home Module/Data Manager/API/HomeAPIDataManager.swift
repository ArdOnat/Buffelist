//
//  HomeAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

class SearchScreenAPIDataManager: HomeAPIDataManagerProtocol {
    
    weak var interactor: HomePresenterToInteractorProtocol?
    
    init(interactor: HomePresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
}
