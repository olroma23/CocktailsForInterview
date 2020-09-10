//
//  NetworkService.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func request(type: String, completion: @escaping (Data?, Error?) -> Void) {
        let params = self.prepareParams(type: type)
        let url = self.url(params: params)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        print(request)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func request(url: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        print(request)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParams(type: String) -> [String: String] {
        var params = [String: String]()
        params["c"] = type
        return params
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thecocktaildb.com"
        components.path = "/api/json/v1/1/filter.php"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
}

