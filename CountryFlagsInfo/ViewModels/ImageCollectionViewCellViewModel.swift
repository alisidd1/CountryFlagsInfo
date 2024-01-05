//
//  ImageCollectionViewCellViewModel.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/7/23.
//

import UIKit

class ImageCollectionViewCellViewModel {
    private let flagImageURL: URL?
    
    init(flagImageURL: URL?) {
        self.flagImageURL = flagImageURL
    }
    
    func getFlagImage(completion: @escaping (UIImage?) -> Void) {
        guard (flagImageURL != nil) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: flagImageURL!)) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let flagImage = UIImage(data: data)
            completion(flagImage)
        }
        task.resume()
    }
}
