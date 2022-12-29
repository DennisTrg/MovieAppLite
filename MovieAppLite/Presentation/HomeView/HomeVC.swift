//
//  HomeViewController.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import UIKit
import SnapKit
class HomeVC: UIViewController {
    
    let viewModel = HomeVcViewModel()
     lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
         
         let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
         collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
         //collectionView.backgroundColor = .clear
         
         collectionView.delegate = self
         collectionView.dataSource = self
         
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        setupView()
        viewModel.requestData(page: 1)
    }
    
    func setupView(){
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.41, height: view.frame.size.height * 0.26)
    }
}

extension HomeVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell()}
        cell.backgroundColor = .red
        return cell
    }
}

//class Colors {
//    var gl: CAGradientLayer?
//
//    init() {
//        let colorTop = UIColor(red: 3 / 255.0, green: 138.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 45.0 / 255.0, green: 85.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor
//
//        self.gl = CAGradientLayer()
//        self.gl?.colors = [colorTop, colorBottom]
//        self.gl?.locations = [0.0, 1.0]
//    }

//        let color = Colors()
//        var backgroundLayer = color.gl
//        backgroundLayer?.frame = view.frame
//        view.layer.insertSublayer(backgroundLayer!, at: 0)
//}
