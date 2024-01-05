//
//  NertworkManager.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 11/29/23.
//

import UIKit

class NertworkManager {
    static let shared = NertworkManager()
    let baseUrl = "https://restcountries.com/v3.1/"
    
    func getCountries(completion: @escaping (Result<[CountryInfoModel], CustomError>) -> Void) {
        
        let endPoint = baseUrl + "all"
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countryInfo = try decoder.decode([CountryInfoModel].self, from: data)
                completion(.success(countryInfo))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
}
