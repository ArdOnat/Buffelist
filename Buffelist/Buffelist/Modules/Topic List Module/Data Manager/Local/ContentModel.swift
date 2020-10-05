//
//  ContentModel.swift
//  Buffelist
//
//  Created by Arda Onat on 4.10.2020.
//

import Foundation

class ContentModel {
    
    var createdAt: DateInfo
    var id: Int
    var imageUrl: String
    var title: String
    var url: String
    
    public init (fromContentInformation contentInformation: ContentInfo) {
        self.createdAt = contentInformation.createdAt
        self.id = contentInformation.id
        self.imageUrl = contentInformation.imageUrl
        self.title = contentInformation.title
        self.url = contentInformation.url
    }
    
}
