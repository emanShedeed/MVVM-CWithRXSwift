//
//  ProductDetailsCollectionViewCell.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit

class ProductDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public var imageURL: String? {
        didSet {
            self.productImageView.loadImage(fromURL: imageURL ?? "")
        }
    }
}
