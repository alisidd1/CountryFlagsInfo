//
//  CountryMapTableViewCell.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 1/1/24.
//

import UIKit
import MapKit
import CoreLocation

class CountryMapTableViewCell: UITableViewCell {
    let identifier = "CountryMapTableViewCell"
 
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mapView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    public func configure(viewModel: CountryMapTableViewCellViewModel) {
        // get long and lat from the country name for getMap()
        
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(viewModel.name, completionHandler: {(placemark, error) -> Void in
            guard error == nil else {
                print("CountryMapTableViewCell: Error in  geoCoder.geocodeAddressString")
                return
            }
            var coordinates: CLLocationCoordinate2D
            if let placemark = placemark?.first {
                coordinates = placemark.location!.coordinate
                let param = viewModel.getMap(longitude: coordinates.longitude, Latitude: coordinates.latitude)
                print("\n\n **** coordinate ***:  \(coordinates.latitude)   \( coordinates.longitude)")
                self.mapView.setRegion(param.region, animated: true)
                self.mapView.addAnnotation(param.annotation)
            }
        })
    }
}




