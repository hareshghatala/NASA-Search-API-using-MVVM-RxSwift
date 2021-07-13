//
//  URLSession+Handler.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import Foundation

extension URLSession {
    
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
