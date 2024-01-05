//
//  CountryDetailViewViewModel.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/29/23.
//

import UIKit

class CountryDetailViewViewModel {
    
    public private (set) var CellTypes: [CountryDetailCellType] = []

    init(countryInfo: CountryInfoModel) {
        CellTypes.append(.map(CountryMapTableViewCellViewModel(name: countryInfo.name.official )))
        CellTypes.append(.country(CountryListTableViewCellViewModel(name: countryInfo.name.official,
                                                                    flagImageURL: URL(string: countryInfo.flags.png))))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Country Name", value: " \(countryInfo.name.official)") ))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Capital", value: countryInfo.capital?.first)))
                                                                            
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Region",
                                                                            value: " \(countryInfo.region.rawValue)") ))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Subregion",
                                                                            value: countryInfo.subregion) ))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Continent",
                                                                            value: countryInfo.region.rawValue) ))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Lanuguages", value: countryInfo.region.rawValue) ))
                                                          //                  value: \(countryInfo.languages?.values.first) ))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Flag",
                                                                            value: countryInfo.flag) ))
        for timezone in countryInfo.timezones {
            CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Time Zone", value: timezone)))
        }
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Area",
                                                                              value: " \(String(countryInfo.area))")))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Car Driving Side", value: (countryInfo.car.side.rawValue).capitalized) ))
        CellTypes.append(.countryDetail(CountryDetailTableViewCellViewModel(name: "Start of Week", value: (countryInfo.startOfWeek.rawValue).capitalized) ))
    }
}
