//
//  SearchViewController.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JellyGif

class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var gifImage: JellyGifImageView!
    var viewModel: SearchForProductViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        gifImage.startGif(with: .name("backGround"))
        setupNavBar()
        setupSearchBar()
    }
    
    func setupNavBar(){
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .darkGray
        searchBar.placeholder = "Search On Jumia"
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil){
        searchBar.resignFirstResponder()
        
    }
 
}
extension SearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else {
            return
        }
        viewModel.navigateToProductsVC(withSearchKey: text)
    }
}
