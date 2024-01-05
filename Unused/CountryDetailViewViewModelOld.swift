//
//  CountryDetailViewViewModelOld.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 1/1/24.
//

import UIKit

class CountryDetailViewViewModelOld {
    
    public private (set) var viewModels: [CountryInfoModelCellType] = []
    let countryInfo: CountryInfoModel

    init(countryInfo: CountryInfoModel) {
        self.countryInfo = countryInfo
        
   //     super.init(nibName: nil, bundle: nil)
        
        var viewModels: [CountryInfoModelCollctionViewCellViewModel] = []
        
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Country Name",
                                                                valueText: " \(countryInfo.name.official)"))
        if let countryCapital = countryInfo.capital {
            viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Capital",
                                                                    valueText: " \(countryCapital[0])"))}
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Region",
                                                                valueText: " \(countryInfo.region.rawValue)"))
        if let subregion = countryInfo.subregion {
            viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Subregion",
                                                                    valueText: " \(subregion)"))}
        if let continent = countryInfo.continents.first?.rawValue {
            viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Continent",
                                                                    valueText: " \(continent)"))}
        if let languages = countryInfo.languages {
            viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Lanuguages",
                                                                    valueText: " \(countryInfo.languages?.values.first ?? "")"))}
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Flag",
                                                                valueText: " \(countryInfo.flag)"))
        
        for timezone in countryInfo.timezones {
            viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Time Zone",
                                                                    valueText: " \(timezone)"))}
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Area",
                                                                valueText: " \(String(countryInfo.area))"))
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Map",
                                                                valueText: " Tap to open Map"))
        //  valueText: " \(countryInfo.maps.googleMaps)"))
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Car Driving Side",
                                                                valueText: " \(countryInfo.car.side.rawValue)"))
        viewModels.append(CountryInfoModelCollctionViewCellViewModel(titleText: " Start of Week",
                                                                valueText: " \(countryInfo.startOfWeek.rawValue)"))
        viewModels.forEach({
            self.viewModels.append(.infoCell($0))
        })
        
        let url = URL(string: countryInfo.flags.png)
        self.viewModels.append(.imageCell(.init(flagImageURL: url)))
        
        if let  coatOfArms = countryInfo.coatOfArms.png {
            let url = URL(string: coatOfArms)
            self.viewModels.append(.imageCell((.init(flagImageURL: url))))
        }
    }
}

