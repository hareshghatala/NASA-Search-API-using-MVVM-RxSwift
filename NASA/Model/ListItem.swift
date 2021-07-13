//
//  ListItem.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

public struct ListItem: Codable {
    
    public let href: String
    public let details: [ItemData]
    public let links: [Link]
    
    enum CodingKeys: String, CodingKey {
        case href
        case details = "data"
        case links
    }
    
    func getDetail() -> ItemData? {
//        guard let details = details else {
//            return nil
//        }
        
        return details.filter { $0.mediaType == mediaTypeText }.first
    }
    
    func getImageLink() -> String? {
//        guard let links = links else {
//            return nil
//        }
        
        return links.filter { $0.render == mediaTypeText }.first?.href
    }
}
