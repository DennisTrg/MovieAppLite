//
//  CollectionViewCell.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "HomeCollectionViewCell"
    let movieImage = UIImageView()
    let movieName = UILabel()
    private let cache = NSCache<NSNumber, UIImage>()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        addView()
     }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImage.image = nil
        self.movieName.text = nil
    }
    
    //MARK: Set up View
    private func addView(){
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(movieName)
        movieName.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        movieName.numberOfLines = 0
        movieName.font = UIFont.systemFont(ofSize: 16)

        view.addSubview(movieImage)
        movieImage.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.bottom.equalTo(movieName.snp.top)
        }
        movieImage.backgroundColor = .gray
        movieImage.clipsToBounds = true
        self.movieImage.image = UIImage(systemName: "arrow.triangle.2.circlepath")
    }
    
    //MARK: Set up Data
    func config(model: HomeListMovie, index: Int){
        movieName.text = model.originalTitle
        
        let itemNum = NSNumber(value: index)

        DispatchQueue.global(qos: .utility).async { [weak self] in
            if let cacheImage = self?.cache.object(forKey: itemNum) {
                DispatchQueue.main.async {
                self?.movieImage.image = cacheImage
                }
            } else {
                guard let imagePath = model.posterPath else {return}
                guard let imageUrl = URL(string: ApiService.ImageUrlString(imagePath: imagePath)) else {return}
                do{
                    let imageData = try Data(contentsOf: imageUrl)
                    guard let image = UIImage(data: imageData) else {return}
                    DispatchQueue.main.async {
                        self?.movieImage.image = image
                        self?.cache.setObject(image, forKey: itemNum)
                    }
                }catch{
                    self?.movieImage.image = UIImage(systemName: "arrow.triangle.2.circlepath")
                }
            }
        }
    }
}


