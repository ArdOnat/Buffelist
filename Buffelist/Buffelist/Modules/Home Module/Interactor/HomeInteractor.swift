//
//  HomeInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

class HomeInteractor {

    weak var presenter: HomeInteractorToPresenterProtocol?
    
    init() {
        
    }
    
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
}
