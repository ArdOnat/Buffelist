//
//  CreateContentResult.swift
//  Buffelist
//
//  Created by Arda Onat on 6.10.2020.
//

struct CreateContentResult: Decodable {
    
    var contentListId: Int
    var createdAt: Int
    var id: Int
    var imageUrl: String
    var title: String
    var url: String
    
}

