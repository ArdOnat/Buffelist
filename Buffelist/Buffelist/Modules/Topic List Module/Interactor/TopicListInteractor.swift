//
//  TopicListInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

class TopicListInteractor {

    weak var presenter: TopicListInteractorToPresenterProtocol?
    var APIDataManager: TopicListAPIDataManagerProtocol?
    //var LocalDataManager: TopicListLocalDataManagerProtocol?

    init() {
        self.APIDataManager = TopicListAPIDataManager(interactor: self)
        //self.LocalDataManager = TopicListLocalDataManager(interactor: self)
    }
    
}

extension TopicListInteractor: TopicListPresenterToInteractorProtocol {
    func onGetContentListSuccess(result: GetContentListResult) {
        let contentList = result.contents.map { ContentModel(fromContentInformation: $0)}.reversed() as [ContentModel]
        presenter?.onGetContentListSuccess(contentList: contentList)
    }
    
    func onGetContentListFailure(error: Error) {
        presenter?.onGetContentListFailure(error: error.localizedDescription)
    }
    
    
    func sendGetContentListRequest(username: String) {
        APIDataManager?.getContentListRequest(username: username)
    }
    
    func sendGetResetLinkRequest(userInfo: String) {
        
    }
    
}
