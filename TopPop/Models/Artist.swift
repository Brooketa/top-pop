//
//  Artist.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct Artist: Codable {
    var name: String
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "picture"
    }
}
