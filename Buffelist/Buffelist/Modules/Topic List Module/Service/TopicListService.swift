//
//  TopicListService.swift
//  Buffelist
//
//  Created by Arda Onat on 4.10.2020.
//

import Foundation
import Alamofire

class TopicListService: TopicListServiceProtocol {
    
    static let endPoint = "https://api.buffelist.com"
    
    static func getContentList(username: String, completion: @escaping (Result<GetContentListResult, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/u/content-list"
        
        let parameters = ["username": username]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: GetContentListResult.self) { response in
            print(response.result)
            completion(response.result)
        }
    }
    
}
