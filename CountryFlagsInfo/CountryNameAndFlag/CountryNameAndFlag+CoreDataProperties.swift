//
//  CountryNameAndFlag+CoreDataProperties.swift
//  CountryNameAndFlag
//
//  Created by Ali Siddiqui on 12/19/23.
//
//

import Foundation
import CoreData


extension CountryNameAndFlag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryNameAndFlag> {
        return NSFetchRequest<CountryNameAndFlag>(entityName: "CountryNameAndFlag")
    }

    @NSManaged public var countryName: String?
    @NSManaged public var countryFlagURLString: String?

}

extension CountryNameAndFlag : Identifiable {

}
