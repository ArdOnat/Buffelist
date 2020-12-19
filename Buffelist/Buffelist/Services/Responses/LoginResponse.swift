//
//  LoginResult.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

struct LoginResult: Decodable {
    
    var id: Int
    var username: String
    var firstName: String?
    var lastName: String?
    var email: String
    var profilePhotoURL: String
    var biography: String?
    
}
