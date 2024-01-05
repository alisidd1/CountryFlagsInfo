//
//  CountryDetailView.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/29/23.
//

import UIKit
import MapKit
import CoreLocation

class CountryDetailView: UIView,  MKMapViewDelegate {
    
    private var viewModel: CountryDetailViewViewModel?
    
    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CountryMapTableViewCell.self,
                           forCellReuseIdentifier: "CountryMapTableViewCell")
        table.register(CountryListTableViewCell.self,
                           forCellReuseIdentifier: "CountryListTableViewCell")
        table.register(CountryDetailInfoTableViewCell.self,
                           forCellReuseIdentifier: "CountryDetailInfoTableViewCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        table.delegate = self
        table.dataSource = self
        addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            table.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            table.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(viewModel: CountryDetailViewViewModel) {
        self.viewModel = viewModel
        table.reloadData()
    }
}

extension CountryDetailView: UITableViewDelegate, UITableViewDataSource   {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.CellTypes.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cellType = viewModel?.CellTypes[indexPath.row]

        switch cellType {
        case .map(let cellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryMapTableViewCell", for: indexPath) as? CountryMapTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(viewModel: cellViewModel)
            return cell

        case .country(let cellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as? CountryListTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(viewModel: cellViewModel)
            return cell

        case .countryDetail(let cellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailInfoTableViewCell", for: indexPath) as? CountryDetailInfoTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(viewModel: cellViewModel)
            return cell


        case .none:
            return UITableViewCell()
        }
    }
}

