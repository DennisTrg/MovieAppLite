//
//  SearchVC.swift
//  MovieAppLite
//
//  Created by Tung Truong on 03/01/2023.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchBar =  UISearchBar()
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        setupView()
        
    }
    
    func setupView(){
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        searchBar.placeholder = "Search"
        //searchBar.inputViewController?.dismissKeyboard()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
        tableView.backgroundColor = .red
        detectTapGesture()
    }
    
}

extension SearchVC{
    //MARK: dismissKeyBoard
    func detectTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
}
