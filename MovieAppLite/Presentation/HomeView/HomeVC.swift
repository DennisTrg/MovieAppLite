//
//  HomeViewController.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import UIKit
import SnapKit
class HomeVC: UIViewController {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        let containerView = UIView()
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        //Search Bar
        let searchBar = UISearchBar()
        containerView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        //Collection View
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = .green

        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)

    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
