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
    var result: MovieListResult?
    let disposeBag = DisposeBag()
    let viewModel = HomeViewModel()
    
     var collectionView: UICollectionView = {
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
    }
    
    //MARK: Set up View
    func setupView(){
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        collectionView.rx.setDelegate(self)
    }
    
    //MARK: Pass Data
    func setupData(){
        viewModel.fetchMovieResult().observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)
        ) {(row, element, cell) in
                cell.config(model: element)
        }
        .disposed(by: disposeBag)
    }
        
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.41, height: view.frame.size.height * 0.34)
    }
}


//        collectionView.rx.modelSelected(MovieListResult.self).subscribe { movie in
//
//        } onError: { <#Error#> in
//            <#code#>
//        } onCompleted: {
//            <#code#>
//        } onDisposed: {
//
//        }
//        collectionView.rx.itemSelected.subscribe { <#IndexPath#> in
//            <#code#>
//        } onError: { <#Error#> in
//            <#code#>
//        } onCompleted: {
//            <#code#>
//        } onDisposed: {
//            <#code#>
//        }
