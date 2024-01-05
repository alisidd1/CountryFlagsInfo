//
//  SearchReultsView.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/27/23.
//

import UIKit

class SearchResultsView: UIView, UITableViewDelegate, UITableViewDataSource {
    lazy var showingSuggestions = false
    
    private var viewModel: SearchResultsViewViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CountryListTableViewCell.self,
                           forCellReuseIdentifier: "CountryListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame:  CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        if let countryViewModel = viewModel?.cellViewModels[indexPath.row] {
            cell.configure(viewModel: countryViewModel)
        }
        return cell
    }
    
    func configure(with viewModel: SearchResultsViewViewModel) {
        self.viewModel = viewModel
    }
}
