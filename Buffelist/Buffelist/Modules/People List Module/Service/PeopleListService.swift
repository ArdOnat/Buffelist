//
//  PeopleListService.swift
//  Buffelist
//
//  Created by Arda Onat on 11.10.2020.
//

import Foundation
import Alamofire

class PeopleListService: PeopleListServiceProtocol {
    
    static let endPoint = "https://api.buffelist.com"
    
    static func getFollowingsOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ()) {
        let completeEndpoint = endPoint + "/api/users/\(username)/followings"
        
        let headers: HTTPHeaders = [
            "Authorization": UserProvider.user().token,
        ]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: [SearchUserResult].self) { response in
            print(response.result)
            completion(response.result)
        }
    }
    
    static func searchUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ()) {
        let completeEndpoint = endPoint + "/api/u/users"
        
        let parameters = ["searchText": username]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: [SearchUserResult].self) { response in
            print(response)
            completion(response.result)
        }
    }

    
}
