//
//  ImageCollectionViewCell.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/6/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    let countryFlagImageView: UIImageView = {
        let countryFlagImageView = UIImageView()
        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        countryFlagImageView.contentMode = .scaleAspectFit
        return countryFlagImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(countryFlagImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        countryFlagImageView.frame = CGRect(x: 5, y: 5, width: Int(contentView.frame.size.width) , height: Int(contentView.frame.size.height))
     //   countryFlagImageView.backgroundColor = .systemPink
   }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryFlagImageView.image = nil
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            countryFlagImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            countryFlagImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            countryFlagImageView.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor),
            countryFlagImageView.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor)
        ])
    }
    
    func configure(viewModel: ImageCollectionViewCellViewModel) {
        viewModel.getFlagImage { [weak self] image   in
                DispatchQueue.main.async {
                    self?.countryFlagImageView.image = image
            }
        }
    }
}
