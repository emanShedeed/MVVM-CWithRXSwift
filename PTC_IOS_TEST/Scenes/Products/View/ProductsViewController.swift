//
//  ProductsViewController.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    
    var viewModel : ProductsViewModel!
    
    let disposeBag = DisposeBag()
    var searchKey:String?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupBinding()
        self.viewModel.savedSearchKey = searchKey ?? ""
    }
    
    private func setupBinding(){
        
        // binding loading to vc
        
        viewModel.loading
                 .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        // observing errors to show
        
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self](error) in
                switch error {
                case .NotFound(let message):
                    self?.showAlert(title: "error", message: message)
                }
            })
            .disposed(by: disposeBag)
        
        
        productsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ProductCollectionViewCell.self))
        
        viewModel.products.bind(to: productsCollectionView.rx.items(cellIdentifier: "ProductCollectionViewCell", cellType: ProductCollectionViewCell.self)) {  [weak self] (row,product,cell) in
            guard let self = self else { return}
            cell.currency = self.viewModel.getCurrency()
            cell.product = product
        }.disposed(by: disposeBag)
    
        productsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        productsCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        productsCollectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.productsCollectionView.contentOffset.y
            let contentHeight = self.productsCollectionView.contentSize.height
            if offSetY > (contentHeight - self.productsCollectionView.frame.size.height - 100) {
                self.viewModel.fetchMoreProducts.onNext(())
            }
        }
        .disposed(by: disposeBag)
        
        productsCollectionView.rx.modelSelected(ItemResult.self).subscribe (onNext: { [weak self] (model) in
            guard let self = self else { return}
            guard let id = model.sku else { return}
            self.viewModel.navigateToProductDetailsVC(withId: id)
        }).disposed(by: disposeBag)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.width
           let cellWidth = width / 2 // compute your cell width
        return CGSize(width: cellWidth, height: cellWidth + (cellWidth * 0.4) )
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
