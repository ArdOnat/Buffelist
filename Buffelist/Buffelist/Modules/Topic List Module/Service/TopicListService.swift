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
    
    static func createContent(info: GetInfoFromUrlResult, contentListId: Int, completion: @escaping (Result<CreateContentResult, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/content"
        
        let headers: HTTPHeaders = [
            "Authorization": UserProvider.user().token,
        ]
     
        let parameters = ["imageUrl": info.imageUrl, "title": info.title, "url": info.url, "contentListId": contentListId] as [String : Any]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .withoutEscapingSlashes
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        print(String(decoding: request.httpBody!, as:UTF8.self))
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(UserProvider.user().token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        AF.request(request).validate().responseDecodable(of: CreateContentResult.self) { response in
            print(request)
            print(response.result)
            completion(response.result)
        }
    }
    
    static func getInfoFromUrl(url: String, completion: @escaping (Result<GetInfoFromUrlResult, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/content/render"
     
        let headers: HTTPHeaders = [
            "Authorization": UserProvider.user().token,
        ]
        
        let parameters = ["url": url]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: GetInfoFromUrlResult.self) { response in
            print(response.result)
            completion(response.result)
        }
        
    }
    
    static func getFollowersOfUser(username: String, completion: @escaping (Result<[SearchUserResult], AFError>) -> ()) {
    
        let completeEndpoint = endPoint + "/api/users/\(username)/followers"
        
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
    
    static func followUser(username: String, completion: @escaping (Result<Data?, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/users/follow/\(username)"
        
        let headers: HTTPHeaders = [
            "Authorization": UserProvider.user().token,
        ]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .post, headers: headers).validate().response { response in
            print(response.result)
            completion(response.result)
        }
        
    }
    
    static func unfollowUser(username: String, completion: @escaping (Result<Data?, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/users/unfollow/\(username)"
        
        let headers: HTTPHeaders = [
            "Authorization": UserProvider.user().token,
        ]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .post, headers: headers).validate().response { response in
            print(response.result)
            completion(response.result)
        }
        
    }
    
}
