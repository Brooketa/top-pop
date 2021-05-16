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
    
    static func fetchTracks(completion: @escaping (TracksResponse?, Error?) -> Void) {
        
        guard let tracksURL = URL(string: APIConstants.tracksRequestURL) else { return }
        
        Network.request(url: tracksURL, completion: { data, error in
            
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
                let result = try JSONDecoder().decode(TracksResponse.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        })
    }
    
    static func fetchAlbum(albumID:String, completion: @escaping (AlbumResponse?, Error?) -> Void) {
        
        guard let tracksURL = URL(string: APIConstants.albumRequestURL + albumID) else { return }
        
        Network.request(url: tracksURL, completion: { data, error in
            
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
                let result = try JSONDecoder().decode(AlbumResponse.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        })
    }
    
}

