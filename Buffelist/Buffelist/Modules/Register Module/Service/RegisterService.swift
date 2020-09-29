//
//  RegisterService.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

import Foundation
import Alamofire

enum RegisterServices {
    case login
    case sendLoginRequest
}

class RegisterService: RegisterServiceProtocol {
    
    static let endPoint = "https://api.buffelist.com"
    
    static func register(username: String, email: String, password: String, completion: @escaping (Result<Data?, AFError>) -> ()) {
        
        let completeEndpoint = endPoint + "/api/u/auth/sign-up"
        
        let parameters = ["username": username, "email": email, "password": password]
        
        guard let url = URL(string: completeEndpoint) else {
            completion(.failure(.invalidURL(url: endPoint)))
            return
        }
        
        AF.upload(multipartFormData: { (multiFormData) in
            for (key, value) in parameters {
                multiFormData.append(Data(value.utf8), withName: key)
            }
        }, to: url).validate().response { response in
            print(response.response)
            print(response.result)
            completion(response.result)
        }
    }
    
}

