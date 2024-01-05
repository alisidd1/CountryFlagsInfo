//
//  CountryListView.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/27/23.
//

import UIKit

protocol CountryListViewDelegate: AnyObject {
    func didSelectACountry(country: CountryInfoModel)
}

class CountryListView: UIView {

    weak var delegate: CountryListViewDelegate?
    let countryLogoImageView = UIImageView()

    private var viewModel: CountryListViewViewModel?
    
    let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CountryListTableViewCell.self,
                           forCellReuseIdentifier: "CountryListTableViewCell")
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        table.delegate = self
        table.dataSource = self
        addSubview(countryLogoImageView)
        addSubview(table)
        configureConstraints()
        configureCountryPageHeaderImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        countryLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryLogoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            countryLogoImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            countryLogoImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            countryLogoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            table.topAnchor.constraint(equalTo: countryLogoImageView.bottomAnchor, constant: 10),
            table.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            table.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureCountryPageHeaderImageView() {
        countryLogoImageView.image = UIImage(named: "Flags")
    }
    
    func configure(viewModel: CountryListViewViewModel) {
        self.viewModel = viewModel
        viewModel.getCountryList { [weak self] in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
    }
}

extension  CountryListView: UITableViewDelegate, UITableViewDataSource {

// MARK: TableView setup

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath)  as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        
        if let cellViewModel = viewModel?.cellViewModels[indexPath.row] {
            cell.configure(viewModel: cellViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = viewModel?.models[indexPath.row] else {
            return
        }
        delegate?.didSelectACountry(country: model)
    }
}
