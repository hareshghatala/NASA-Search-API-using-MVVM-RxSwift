//
//  ItemData.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import Foundation

public struct ItemData: Codable {
    
    public let description: String?
    public let mediaType: String?
    public let dateCreated: Date?
    public let title: String?
    public let photographer: String?
    public let nasaId: String?
    
}
