//
//  ProductCollectionViewCell.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var specialPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    var currency:String?
    public var product: ItemResult! {
         didSet {
            self.productImageView.loadImage(fromURL: product.image ?? "")
            self.brandNameLabel.text = product.brand
            self.productNameLabel.text = product.name
            let specialprice = product.specialPrice != nil ? "\(currency ?? "")\(product.specialPrice ?? 0)" : ""
            self.specialPriceLabel.text = specialprice
            let price = product.price != nil ? "\(currency ?? "")\(product.price ?? 0)" : ""
            self.priceLabel.attributedText = price.strikeThrough()
            let discountPercentage = product.maxSavingPercentage != nil ? " -\(product.maxSavingPercentage ?? 0)% " : ""
            self.discountPercentageLabel.text = discountPercentage
            self.starRatingView.rating = product.ratingAverage ?? 0
         }
     }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
