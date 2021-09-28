//
//  ProductDetailsViewController.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productSpecialPriceLabel: UILabel!
    @IBOutlet weak var maxSavingPercentageLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var ratingTotalLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var viewModel : ProductDetailsviewModel!
    
    let disposeBag = DisposeBag()
    //    var currentImage : String?
    var productId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupBinding()
        viewModel.fetchProduct(with: productId ?? "")
    }
    private func setupBinding() {
        
        // binding loading to vc
        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        // observing errors to show
        
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                switch error {
                case .NotFound(let message):
                    //AlertDisplayer.showAlert(title: "error", message: message, VC: self)
                    self?.showAlert(title: "error", message: message)
                }
            })
            .disposed(by: disposeBag)
        
        
        productImagesCollectionView.register(UINib(nibName: "ProductDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ProductDetailsCollectionViewCell.self))
        
        viewModel.productImages.bind(to: productImagesCollectionView.rx.items(cellIdentifier: "ProductDetailsCollectionViewCell", cellType: ProductDetailsCollectionViewCell.self)) {  (row,imageURL,cell) in
            cell.imageURL = imageURL
        }.disposed(by: disposeBag)
        
        productImagesCollectionView.rx.modelSelected(String.self).subscribe (onNext: { [weak self] (imageURL) in
            guard let self = self else { return}
            self.viewModel.mainProductImage.onNext(imageURL)
        }).disposed(by: disposeBag)
        
        
        productImagesCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        viewModel.mainProductImage.subscribe(onNext: { [weak self] imageURL in
            guard let self = self else { return}
            self.productImageView.loadImage(fromURL: imageURL)
        }).disposed(by: disposeBag)
        
        viewModel.productBrand.bind(to: productBrandLabel.rx.text).disposed(by: disposeBag)
        viewModel.productName.bind(to: productNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.productSpecialPrice.bind(to: productSpecialPriceLabel.rx.text).disposed(by: disposeBag)
        viewModel.productPrice.bind(to: productPriceLabel.rx.attributedText).disposed(by: disposeBag)
        viewModel.maxSavingPercentage.bind(to: maxSavingPercentageLabel.rx.text).disposed(by: disposeBag)
        viewModel.rating.bind(to: ratingView.rx.rating).disposed(by: disposeBag)
        viewModel.ratingsTotal.bind(to: ratingTotalLabel.rx.text).disposed(by: disposeBag)
        viewModel.description.bind(to: descriptionTextView.rx.text).disposed(by: disposeBag)
        
    }
    
    func showAlert(title:String, message:String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .cancel) { [weak self]_ in
            guard let self = self else { return}
            self.viewModel.popView()
        }
        alertVC.addAction(ok)
        self.present(alertVC, animated: true, completion: nil)
    }
}
