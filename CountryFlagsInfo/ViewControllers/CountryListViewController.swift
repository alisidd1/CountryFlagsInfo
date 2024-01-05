//
//  CountryListViewController.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 11/28/23.
//

import UIKit

class CountryListViewController: UIViewController, CountryListViewDelegate {

    private let searchResultsVC = SearchResultsViewController()
    private let viewModel = CountryListViewViewModel()
    
    override func loadView() {
        let _view = CountryListView()
        _view.delegate = self
        _view.configure(viewModel: viewModel)
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "World Countries"
        setupSearchController()
    }
}

// MARK: - Search Functions

extension CountryListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: searchResultsVC)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Countries"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        updateSearchController(searchBarText: text)
    }
    
    func didSelectACountry(country: CountryInfoModel) {
        let countryDetailVC = CountryDetailViewController(countryInfo: country)
        navigationController?.pushViewController(countryDetailVC, animated: true)
    }
}

// MARK: - Search Filtering Function

extension CountryListViewController {
    
    func updateSearchController(searchBarText: String?) {
        var filteredCountryListViewViewModels = [CountryListTableViewCellViewModel]()
        
        let countryListView = self.view as? CountryListView
        
        let searchText = searchBarText?.lowercased()
        filteredCountryListViewViewModels = (self.viewModel.cellViewModels).filter({
            $0.name.lowercased().contains(searchText!)})
        
        // search VC
        searchResultsVC.update(viewModels: filteredCountryListViewViewModels )
    }
}


