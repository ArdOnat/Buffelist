//
//  LoginResult.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

struct LoginResult: Decodable {
    
    var id: Int
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var profilePhotoURL: String
    var biography: String
    /*
    "id": 261,
    "username": "ArdOnat",
    "firstName": "Arda",
    "lastName": "Onat",
    "email": "ardonat97@hotmail.com",
    "profilePhotoURL": "https://buffelist.s3.eu-central-1.amazonaws.com/profile_photos/ArdOnat",
    "biography": "iOS Developer at Hepsiburada"
 */
}
