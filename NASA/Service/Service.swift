//
//  Service.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class Service {
    
    public static let shared = Service()
    private init() {}
    
    private let urlSession = URLSession.shared
    
    private let baseURL = URL(string: "https://images-api.nasa.gov")!
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    // Enum Endpoint
    enum Endpoint: String {
        case search
    }
    
    private func fetchResources<T: Decodable>(url: URL, queryParams: [String: String]? = nil, completion: @escaping (Result<T, ServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        if let queryParams = queryParams?.map({ URLQueryItem(name: $0.key, value: $0.value) }) {
            urlComponents.queryItems = queryParams
        }
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { result in
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    do {
                        let values = try self.jsonDecoder.decode(T.self, from: data)
                        completion(.success(values))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                
                case .failure( _):
                    completion(.failure(.apiError))
            }
        }.resume()
    }
    
    
    public func fetchNasaImages(searchText: String = "\"\"", result: @escaping (Result<NasaSearch, ServiceError>) -> Void) {
        
        let params: [String: String] = [ "q": searchText ]
        let infoURL = baseURL
            .appendingPathComponent(Endpoint.search.rawValue)
        
        fetchResources(url: infoURL, queryParams: params, completion: result)
    }
    
}
