//
//  TracksApiResponse.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct TracksResponse: Codable {
    var tracksData: TracksData
    
    enum CodingKeys: String, CodingKey {
        case tracksData = "tracks"
    }
}
