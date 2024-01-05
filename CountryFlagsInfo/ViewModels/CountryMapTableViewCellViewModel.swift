//
//  CountryMapTableViewCellViewModel.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 1/2/24.
//

import UIKit
import MapKit
import CoreLocation

class CountryMapTableViewCellViewModel {
    public var name: String

    init(name: String) {
        self.name = name
    }

    func getMap(longitude: Double, Latitude: Double) -> (region: MKCoordinateRegion, annotation: MKPointAnnotation) {
        let longitude = longitude
        let latitude = Latitude
        
        let latDelta: CLLocationDegrees = 7
        let lonDelta: CLLocationDegrees = 7
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        
        return(region, annotation)
    }
}

