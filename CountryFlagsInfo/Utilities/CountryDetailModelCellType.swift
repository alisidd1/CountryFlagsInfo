//
//  CountryDetailCellType.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 1/1/24.
//

import UIKit

enum CountryDetailCellType {
    case map(CountryMapTableViewCellViewModel)
    case country(CountryListTableViewCellViewModel)
    case countryDetail(CountryDetailTableViewCellViewModel)
}
