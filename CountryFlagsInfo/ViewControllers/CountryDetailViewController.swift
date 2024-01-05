//
//  CountryDetailViewController.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 11/28/23.
//

import UIKit

class CountryDetailViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favCountries = [CountryNameAndFlag]()
    var observer: NSObjectProtocol?
    let countryInfo: CountryInfoModel

    init(countryInfo: CountryInfoModel) {
        self.countryInfo = countryInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let viewModel = CountryDetailViewViewModel(countryInfo: countryInfo)
        let _view = CountryDetailView()
        _view.configure(viewModel: viewModel)
        view = _view
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        title = ("\(countryInfo.name.common) Information")
        getAllCountriesToStarUnstar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllCountriesToStarUnstar()
    }
    
    func getAllCountriesToStarUnstar() {
        do {
            favCountries = try context.fetch(CountryNameAndFlag.fetchRequest())
        } catch {
            // how to handle error - pop up????? ali
        }

        if favCountries.contains(where: { $0.countryName == "\(countryInfo.name.official)" }) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        }
    }
    
    func setupObserver(){
        observer = NotificationCenter.default.addObserver(forName: Notification.Name(
                                                        "country deleted"),
                                                        object: nil,
                                                        queue: .main, using: { (notification) in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: nil)
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func favoriteButtonTapped() {  // this is a binary action - first tap adds, second tap remove
        // This function saves and if-already-saved deletes the country from DB and updates the Star icon on top RHS.
        // Get all the fav. countries to check if this country is already saved.
        do {
            favCountries = try context.fetch(CountryNameAndFlag.fetchRequest())
        } catch {
            // how to handle error - pop up????? ali
        }

        if let modelToDelete = favCountries.first(where: { $0.countryName == "\(countryInfo.name.official)" }) {
            removeCountryInfoModelFromDatabase(model: modelToDelete)
            NotificationCenter.default.post(name: Notification.Name("country list updated"), object: countryInfo )
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
            addCountryInfoModelToDatabase(countryName: countryInfo.name.official, countryFlagURLString:  countryInfo.flags.png)
            NotificationCenter.default.post(name: Notification.Name("country list updated"), object: countryInfo )
        }
    }
    
    @objc func dismissActionController() {
        self.dismiss(animated: true)
    }
    
    func addCountryInfoModelToDatabase(countryName: String, countryFlagURLString: String ) {
        let countryToBeAdded = CountryNameAndFlag(context: context)
        countryToBeAdded.countryName = countryName
        countryToBeAdded.countryFlagURLString = countryFlagURLString
        
        do {
            try context.save()
        }
        catch {
                // how to handle error
        }
    }
    
    func removeCountryInfoModelFromDatabase(model: CountryNameAndFlag) {
        context.delete(model)
        do {
            try context.save()
        }
        catch {
            // how to handle error
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("CountryDetailViewController :   cell tapped")
    }
}
