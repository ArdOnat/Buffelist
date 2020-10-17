//
//  SearchUserResponse.swift
//  Buffelist
//
//  Created by Arda Onat on 8.10.2020.
//

struct SearchUserResult: Decodable {
    
    var biography: String?
    var email: String?
    var firstName: String?
    var id: Int
    var lastName: String?
    var profilePhotoURL: String?
    var username: String
    
}
