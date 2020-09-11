//
//  NetworkDataFetcher.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation


class NetworkDataFetcher {
    
    static let shared = NetworkDataFetcher()
    private init() {}

    func fetchData(type: String, completion: @escaping (Result?) -> Void) {
        NetworkService.shared.request(type: type) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                let decoded = self.decodeJSON(type: Result.self, from: data)
                completion(decoded)
            }
        }
    }
    
    func fetchData(completion: @escaping (Categories?) -> Void) {
        NetworkService.shared.request(url: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list") { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                let decoded = self.decodeJSON(type: Categories.self, from: data)
                completion(decoded)
            }
        }
    }
    
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
             print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}
