//
//  PictureCollectionViewCell.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    var pictureImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pictureImageView = UIImageView(frame: .zero)
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.contentMode = .scaleAspectFit
        contentView.addSubview(pictureImageView)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        super.updateConstraints()
    }
    
    func configure(with picture: Picture) {
        pictureImageView.image = UIImage(named: picture.preview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
