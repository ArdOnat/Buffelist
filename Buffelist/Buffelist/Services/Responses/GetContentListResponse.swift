//
//  GetContentListResponse.swift
//  Buffelist
//
//  Created by Arda Onat on 4.10.2020.
//

import Foundation

struct GetContentListResult: Decodable {
    
    var contents: [ContentInfo]
    var id: Int
    var name: String
    
}

struct ContentInfo: Decodable {
    
    var createdAt: DateInfo
    var id: Int
    var imageUrl: String
    var title: String
    var url: String
    
}

struct DateInfo: Decodable {
    
    var epochSecond: Int
    var nano: Int
    
    var date: String {
        let date = Date(timeIntervalSince1970: Double(epochSecond))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYY"
        return dateFormatter.string(from: date)
    }
    
}


