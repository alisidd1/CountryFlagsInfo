//
//  CountryDetailInfoTableViewCell.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 1/1/24.
//

import UIKit

class CountryDetailInfoTableViewCell: UITableViewCell {
    let identifier = "CountryDetailInfoTableViewCell"
    
    let countryInfoTitle: UILabel = {
        let countryInfoTitle = UILabel()
        countryInfoTitle.translatesAutoresizingMaskIntoConstraints = false
        return countryInfoTitle
    }()
    
    let countryInfoDetail: UILabel = {
        let countryInfoDetail = UILabel()
        countryInfoDetail.translatesAutoresizingMaskIntoConstraints = false
        countryInfoDetail.numberOfLines = 0
        return countryInfoDetail
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(countryInfoTitle)
        contentView.addSubview(countryInfoDetail)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            countryInfoTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            countryInfoTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            countryInfoTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50),
 //           countryInfoTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            countryInfoTitle.widthAnchor.constraint(equalToConstant: 150),
            countryInfoTitle.heightAnchor.constraint(equalToConstant: 34),
            
            countryInfoDetail.topAnchor.constraint(equalTo: contentView.topAnchor),
            countryInfoDetail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            countryInfoDetail.leftAnchor.constraint(equalTo: countryInfoTitle.rightAnchor, constant: 10),
            countryInfoDetail.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryInfoTitle.text = nil
        countryInfoDetail.text = nil
    }
    
    public func configure(viewModel: CountryDetailTableViewCellViewModel) {
        countryInfoTitle.text = viewModel.titleText
        countryInfoDetail.text = viewModel.valueText
        
    }
}

    

