//
//  NasaSearch.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

public struct NasaSearch: Codable {
    
    public let collection: Collection
    
}

public struct Collection: Codable {
    
    public let items: [ListItem]
    
}
