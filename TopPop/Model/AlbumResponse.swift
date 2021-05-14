//
//  AlbumResponse.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct AlbumResponse: Codable {
    var tracksData: TracksData
    var coverImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case tracksData = "tracks"
        case coverImageURL = "cover"
    }
}
