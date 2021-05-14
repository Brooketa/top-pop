//
//  Network.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation
import Alamofire

class Network {
    
    static func request(url:URL, completion: @escaping (Data?, Error?) -> Void) {
        AF.request(url).validate().responseData(completionHandler: { response in
            switch response.result {
            case .success(let responseData):
                guard let data = responseData as Data? else {
                    completion(nil,nil)
                    return
                }
                completion(data,nil)
                break
            case .failure(let error):
                completion(nil, error)
                print("\(error)")
                break
            }
        })
    }
    
}
