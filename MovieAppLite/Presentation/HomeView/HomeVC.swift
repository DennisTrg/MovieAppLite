//
//  HomeViewController.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    
    let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    let customRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        return refreshControl
    }()
    
     let collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
         
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        setupView()
        setupData()
        viewModel.fetchMovieResult(url: ApiService.urlString(category: "popular", page: 1))
    }
    
    //MARK: Set up View
    private func setupView(){
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        collectionView.rx.setDelegate(self)
        collectionView.refreshControl = customRefreshControl
    }
    
    //MARK: Pass Data
    private func setupData(){
        viewModel.listMovieHome.observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)){
                (row, element, cell) in
                cell.config(model: element, index: row)
            }.disposed(by: disposeBag)
        
        customRefreshControl.rx.controlEvent(.valueChanged).asDriver().drive(onNext:{[weak self] in
            self?.viewModel.fetchMovieResult(url: ApiService.urlString(category: "popular", page: 1))
            self?.collectionView.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.41, height: view.frame.size.height * 0.34)
    }
}

