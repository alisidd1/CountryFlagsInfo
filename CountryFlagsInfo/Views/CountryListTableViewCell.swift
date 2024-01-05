//
//  CountryListTableViewCell.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 11/28/23.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    let identifier = "CountryListTableViewCell"
 
    let flagImageView: UIImageView = {
        let flagImageView = UIImageView()
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.contentMode = .scaleAspectFit
        return flagImageView
    }()
        
    let countryNameLabel: UILabel = {
        let countryNameLabel = UILabel()
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.numberOfLines = 0
        return countryNameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(flagImageView)
        contentView.addSubview(countryNameLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            flagImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            flagImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            flagImageView.widthAnchor.constraint(equalToConstant: 30),
            flagImageView.heightAnchor.constraint(equalToConstant: 30),
        
            countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            countryNameLabel.leftAnchor.constraint(equalTo: flagImageView.rightAnchor, constant: 10),
            countryNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            countryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        countryNameLabel.text = nil
        flagImageView.image = nil
    }

    public func configure(viewModel: CountryListTableViewCellViewModel) {
        countryNameLabel.text = viewModel.name
        viewModel.getImage { [weak self] image in
            DispatchQueue.main.async {
                self?.flagImageView.image = image
            }
        }
    }
}
