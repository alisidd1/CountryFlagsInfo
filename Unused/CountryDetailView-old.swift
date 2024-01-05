//
//  CountryDetailViewOld.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/29/23.
//

import UIKit

class CountryDetailViewOld: UIView, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: CountryDetailViewViewModel?
    
    private let collectionView: UICollectionView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 20, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        backgroundColor = .systemBackground
        addConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CountryDetailCollectionViewCell.self, forCellWithReuseIdentifier: CountryDetailCollectionViewCell.identifier)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 20, height: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
        
    func configure(viewModel: CountryDetailViewViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension CountryDetailViewOld: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.viewModels.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = viewModel?.viewModels[indexPath.row]
        
        switch cellType {
        case.imageCell(let cellViewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
                return  UICollectionViewCell()
            }
            cell.configure(viewModel: cellViewModel)
            return cell
            
        case.infoCell(let cellViewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryDetailCollectionViewCell.identifier, for: indexPath) as? CountryDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(viewModel: cellViewModel)
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}
