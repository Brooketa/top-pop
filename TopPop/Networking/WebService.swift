//
//  WebService.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct APIConstants {
    static let albumRequestURL = "https://api.deezer.com/album/"
    static let tracksRequestURL = "https://api.deezer.com/chart"
}

class WebService {
    
    static func fetchData<T:Codable>(albumID:String? = nil, completion: @escaping (T?, Error?) -> Void) {
        
        var url:URL?
        
        if let albumID = albumID {
            url = URL(string: APIConstants.albumRequestURL + albumID)
        } else {
            url = URL(string: APIConstants.tracksRequestURL)
        }
        
        guard let url = url else { return }
        
        Network.request(url: url, completion: { data, error in
            
            if let error = error {
                print("Finished with error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        })
    }
}

