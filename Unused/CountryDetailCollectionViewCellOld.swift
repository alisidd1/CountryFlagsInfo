//
//  CountryDetailCollectionViewCellOld.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 1/1/24.
//

import UIKit

class CountryDetailCollectionViewCellOld: UICollectionViewCell {
    static let identifier =  "CountryDetailCollectionViewCell"
    var imgSize = UIImageView()

    let countryDetailCollectionViewLabel: UILabel = {
        let countryDetailCollectionViewLabel = UILabel()
        countryDetailCollectionViewLabel.translatesAutoresizingMaskIntoConstraints = false
        countryDetailCollectionViewLabel.numberOfLines = 0
        countryDetailCollectionViewLabel.font = .systemFont(ofSize: 20)
        countryDetailCollectionViewLabel.lineBreakMode = .byWordWrapping
        return countryDetailCollectionViewLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(countryDetailCollectionViewLabel)
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: "world")!).withAlphaComponent(0.25)
     
        NSLayoutConstraint.activate([
            countryDetailCollectionViewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            countryDetailCollectionViewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            countryDetailCollectionViewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            countryDetailCollectionViewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ] )
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CountryInfoModelCollctionViewCellViewModel ) {
        var countryDetailCollectionViewLabelText = viewModel.valueText
        countryDetailCollectionViewLabel.text = viewModel.titleText
        if countryDetailCollectionViewLabel.text != nil, countryDetailCollectionViewLabelText != nil {
            countryDetailCollectionViewLabel.text! = countryDetailCollectionViewLabel.text! + ":";
            countryDetailCollectionViewLabel.text! += countryDetailCollectionViewLabelText!
        } else {
            countryDetailCollectionViewLabelText = "Info unavailable"
        }
    }
}

