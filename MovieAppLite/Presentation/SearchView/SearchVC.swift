//
//  SearchVC.swift
//  MovieAppLite
//
//  Created by Tung Truong on 03/01/2023.
//

import UIKit
import RxSwift

class SearchVC: UIViewController, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    let tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        tap.numberOfTapsRequired = 1
        return tap
    }()
    let viewModel = MovieSearchViewModel()
    let disposeBag = DisposeBag()
    let searchBar =  UISearchBar()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        setupView()
        setupData()
    }
    
    private func setupView(){
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        searchBar.placeholder = "Search"
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
        
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext:{[weak self] (recognizer) in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    private func setupData(){
        
        tableView.rx.setDelegate(self)
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.fetchMovieResult(keyword: $0, page: 1)
            }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.asDriver().drive(onNext:{[weak self] in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        viewModel.movieDetail
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)){
                (row, element, cell) in
                cell.config(model: element, index: row)
                
            }.disposed(by: disposeBag)
    }
}

extension SearchVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.safeAreaLayoutGuide.layoutFrame.height / 4)
    }
}

