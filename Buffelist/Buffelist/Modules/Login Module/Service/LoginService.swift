//
//  UserService.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

import Foundation
import Alamofire

class LoginService: LoginServiceProtocol {
    
    static let endPoint = "https://api.buffelist.com"
    
    static func login(userInfo: String, password: String, completion: @escaping (Result<LoginResult, AFError>, String) -> ()) {
        
        let completeEndpoint = endPoint + "/api/u/auth/login"
        
        let parameters = ["usernameOrEmail": userInfo, "password": password]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)), "")
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: LoginResult.self) { response in
            completion(response.result, response.response?.headers.dictionary["Authorization"] ?? "" )
        }
    }
    
    static func getResetLink(userInfo: String, completion: @escaping (Result<Data?, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/u/auth/forgot-password"
        
        let parameters = ["usernameOrEmail": userInfo]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().response() { response in
            completion(response.result)
        }
    }
    
}
