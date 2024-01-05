//
//  CountryListViewViewModel.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/27/23.
//

import UIKit

class CountryListViewViewModel {
        
    public private (set) var cellViewModels: [CountryListTableViewCellViewModel] = []
    public private(set) var  models = [CountryInfoModel]()
    
    // MARK: - Network Functions

    func getCountryList( completion: @escaping  () -> Void) {
        NertworkManager.shared.getCountries { [weak self] result in
            guard let self = self else { return }
            switch(result) {
            case .success(let response):
                self.models = response
                    for countryInfo in response {
                        let cellViewModel = CountryListTableViewCellViewModel(
                            name: countryInfo.name.official,
                            flagImageURL: URL(string: countryInfo.flags.png)
                        )
                        self.cellViewModels.append(cellViewModel)
                    }
                    completion()
                
            case .failure(_):
                print("Error in getting country data - USE AN ALERT VIEW")
                break
            }
        }
    }
}

