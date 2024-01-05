
//  SearchResultsViewController.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/22/23.
//

import UIKit

class SearchResultsViewController: UIViewController{

    override func loadView() {
        view = SearchResultsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func update(viewModels: [CountryListTableViewCellViewModel] ) {
        let viewModel = SearchResultsViewViewModel(
            cellViewModels: viewModels
        )
        (view as? SearchResultsView)?.configure(with: viewModel)
    }
}
