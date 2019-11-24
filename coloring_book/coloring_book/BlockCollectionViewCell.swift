//
//  BlockCollectionViewCell.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//

import UIKit

class BlockCollectionViewCell: UICollectionViewCell {
    
    var blockColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = blockColor
    }
    
    //    var blockImageView: UIImageView!
    //
    //
    //
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        blockImageView = UIImageView(frame: .zero)
    //        blockImageView.translatesAutoresizingMaskIntoConstraints = false
    //        blockImageView.contentMode = .scaleAspectFit
    //        contentView.addSubview(blockImageView)
    //    }
    //
    //    override func updateConstraints() {
    //        NSLayoutConstraint.activate([
    //            blockImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
    //            blockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
    //            blockImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    //            blockImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    //            ])
    //
    //        super.updateConstraints()
    //    }
    //
    //    //NEED TO FIGURE OUT CHANGING PICTURE TO COLOR
    //    func configure(with block: Block) {
    //        blockImageView.image = UIImage(named: picture.preview)
    //    }
    
    func configure(with block: Block) {
        if block.isTapped == true {
            block.code = 1
            backgroundColor = .black
        }
        else{
            block.code = 0
            backgroundColor = .white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
