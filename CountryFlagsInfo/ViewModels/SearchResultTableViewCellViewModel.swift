//
//  SearchResultTableViewCellViewModel.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/25/23.
//

import UIKit

class SearchResultTableViewCellViewModel {
    public var name: String
    private var flagImageURL: URL?
    
    init(name: String, flagImageURL: URL?) {
        self.name = name
        self.flagImageURL = flagImageURL
    }
    
    public func getImage(completion: @escaping (UIImage?) -> Void ) {
        guard let flagImageURL else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: flagImageURL)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
}
