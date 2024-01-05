//
//  FavoriteListViewController.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/12/23.
//

import UIKit

class FavoriteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var viewModels: [CountryListTableViewCellViewModel] = []
    var favCountries = [CountryNameAndFlag]()

    var observer: NSObjectProtocol?
    
    let favoriteTable:  UITableView = {
        let favoriteTable = UITableView()
        favoriteTable.register(CountryListTableViewCell.self, forCellReuseIdentifier: "CountryListTableViewCell")
        favoriteTable.translatesAutoresizingMaskIntoConstraints = false
        return favoriteTable
    }()
    
    let noFavoritesTextLabel: UILabel = {
        let noFavoritesTextLabel = UILabel()
        noFavoritesTextLabel.backgroundColor = .systemBackground
        noFavoritesTextLabel.text = "No Favorites!"
        noFavoritesTextLabel.textAlignment = .center
        noFavoritesTextLabel.layer.borderWidth = 4
        noFavoritesTextLabel.layer.borderColor = UIColor.red.cgColor
        noFavoritesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return noFavoritesTextLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        favoriteTable.dataSource = self
        favoriteTable.delegate = self
        view.addSubview(favoriteTable)
        view.addSubview(noFavoritesTextLabel)
        getAllItemsFromDB()
        setupConstraints()
        setupObserver()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashAllFavoriteitems))
    }
    
    @objc func trashAllFavoriteitems() {
        if self.viewModels.isEmpty { return }
        let alert = UIAlertController(title: "Delete", message: "Do you want to delete all Favorite Countries?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete All", style: UIAlertAction.Style.destructive, handler: { action in
            self.viewModels.removeAll()
            self.favoriteTable.reloadData()
            self.favoriteTable.isHidden = true
            self.noFavoritesTextLabel.isHidden = false
            do {
                let favoriteCountries = try self.context.fetch(CountryNameAndFlag.fetchRequest())
                for country in favoriteCountries {
                    self.context.delete(country)
                    do {
                        try self.context.save()
                    }
                    catch {
                        print("save FAILED after deletion from Database ")
                    }
                    // Notify deletion to CountryDetailViewController to unstar
                    NotificationCenter.default.post(name: Notification.Name("country deleted"), object: nil)
                }
            } catch {
                print("delete from Database FAILED")
                
            }
        }))
        self.present(alert, animated: true)
    }
    
    func setupObserver() {
        observer = NotificationCenter.default.addObserver(forName: Notification.Name(
                                                        "country list updated"),
                                                        object: nil,
                                                        queue: .main, using: { (notification) in
            self.viewModels.removeAll()
            self.getAllItemsFromDB()
        })
    }
    
    func getAllItemsFromDB() {
        do {
            let favoriteCountries = try context.fetch(CountryNameAndFlag.fetchRequest())
            if favoriteCountries.isEmpty {
                favoriteTable.isHidden = true
                noFavoritesTextLabel.isHidden = false
            } else {
                favoriteTable.isHidden = false
                noFavoritesTextLabel.isHidden = true
                for country in favoriteCountries {
                    let cellViewModel = CountryListTableViewCellViewModel(
                        name: country.countryName!,
                        flagImageURL: URL(string: country.countryFlagURLString!))
                    self.viewModels.append(cellViewModel)
                }
                favoriteTable.reloadData()
            }
        }
        catch {
                // alert to report error
            print("FavoriteListViewController: Error getAllItemsFromDB() ")
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            favCountries = try context.fetch(CountryNameAndFlag.fetchRequest())
        } catch {
            // how to handle error - pop up????? ali
            print("favoriteButtonTapped: getting fav countries from DB failed")
        }
        print("stop")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           // remove one country from DB
            do {
                let favoriteCountries = try context.fetch(CountryNameAndFlag.fetchRequest())
                if let countryToDelete = favoriteCountries.first(where: { $0.countryName == viewModels[indexPath.row].name }) {
                    context.delete(countryToDelete)
                    do {
                        try context.save()
                    }
                    catch {
                        print("addCountryInfoModelToDatabase FAILED")
                    }
                    // notify CounntryInfoViewController about this deletion to update fav star icon.
                    NotificationCenter.default.post(name: Notification.Name("country deleted"), object: nil)
                    self.viewModels.removeAll()
                    self.getAllItemsFromDB()
                }
            } catch {
                    // alert to report error
                print("FavoriteListViewController: Error context.fetch(CountryNameAndFlag.fetchRequest() ")
            }
        }
    }
 
    func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            favoriteTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            favoriteTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            favoriteTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 10),
            
            noFavoritesTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            noFavoritesTextLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            noFavoritesTextLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            noFavoritesTextLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50)
        ])
    }
}
