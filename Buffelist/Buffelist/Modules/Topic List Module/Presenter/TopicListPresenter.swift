//
//  TopicListPresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

class TopicListPresenter {
    
    weak var view: TopicListPresenterToViewProtocol?
    var interactor: TopicListPresenterToInteractorProtocol?
    var router: TopicListWireframeProtocol?
    
    init( view: TopicListPresenterToViewProtocol, interactor: TopicListPresenterToInteractorProtocol, router: TopicListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension TopicListPresenter: TopicListViewToPresenterProtocol {
    
    func getContentList(username: String) {
        interactor?.sendGetContentListRequest(username: username)
    }
    
    func getResetLink(userInfo: String) {
        
    }

}

extension TopicListPresenter: TopicListInteractorToPresenterProtocol {
    
    func onGetContentListSuccess(contentList: [ContentModel]) {
        view?.onGetContentListSuccess(contentList: contentList)
    }
    
    func onGetContentListFailure(error: String) {
        view?.onGetContentListFailure(error: error)
    }
    
}
