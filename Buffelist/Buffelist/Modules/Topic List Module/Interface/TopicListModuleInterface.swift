//
//  TopicListModuleInterface.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

import UIKit

//MARK: ModuleBuilder -

protocol TopicListModuleBuilderProtocol {
    func createModule(username: String) -> UINavigationController
}

//MARK: Wireframe -
protocol TopicListWireframeProtocol {
    func navigateToPlatform(view: TopicListPresenterToViewProtocol)
    func navigateToLogin(view: TopicListPresenterToViewProtocol)
    func navigateToRegister(view: TopicListPresenterToViewProtocol)
}

//MARK: View -
protocol TopicListPresenterToViewProtocol: class {
    var presenter: TopicListViewToPresenterProtocol?  { get set }
    func getContentList(username: String)
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: String)
}

protocol TopicListViewUserActionHandler {
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl)
}

//MARK: Presenter -
protocol TopicListViewToPresenterProtocol: class {
    var view: TopicListPresenterToViewProtocol? { get set }
    func getContentList(username: String)
}

protocol TopicListInteractorToPresenterProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    func getContentList(username: String)
    func onGetContentListSuccess(contentList: [ContentModel])
    func onGetContentListFailure(error: String)
}

//MARK: Interactor -
protocol TopicListPresenterToInteractorProtocol: class {
    var presenter: TopicListInteractorToPresenterProtocol?  { get set }
    func sendGetContentListRequest(username: String)
    func onGetContentListSuccess(result: GetContentListResult)
    func onGetContentListFailure(error: Error)
}

//MARK: APIDataManager -
protocol TopicListAPIDataManagerProtocol: class {
    var interactor: TopicListPresenterToInteractorProtocol? { get set }
    func getContentListRequest(username: String)
}

//MARK: Service -
protocol TopicListServiceProtocol {
    static func getContentList(username: String, completion: @escaping (Result<GetContentListResult, AFError>) -> ())
}
