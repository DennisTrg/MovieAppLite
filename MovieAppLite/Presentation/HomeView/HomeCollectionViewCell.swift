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
    func addView(){
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
    func config(model: MovieListResult){
        movieName.text = model.originalTitle

        DispatchQueue.global().async {
            guard let imagePath = model.posterPath else {return}
            guard let imageUrl = URL(string: ApiService.ImageUrlString(imagePath: imagePath)) else {return}
            do{
                let image = try Data(contentsOf: imageUrl)
                DispatchQueue.main.async { [weak self]  in
                    self?.movieImage.image = UIImage(data: image)
                }
            }catch{
                self.movieImage.image = UIImage(systemName: "arrow.triangle.2.circlepath")
            }
        }
    }
}
