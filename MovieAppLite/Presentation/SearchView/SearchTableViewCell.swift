//
//  SearchTableViewCell.swift
//  MovieAppLite
//
//  Created by Tung Truong on 03/01/2023.
//

import UIKit
import Cosmos
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img_placeholder")
        return imageView
    }()
    
    let movieName: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        name.numberOfLines = 0
        name.minimumScaleFactor = 1
        name.text = "Avatar: Water Sea Ocean Avatar: Water Sea OceanAvatar: Water Sea OceanAvatar: Water Sea OceanAvatar: Water Sea OceanAvatar: Water Sea OceanAvatar: Water Sea Ocean"
        return name
    }()
    
    let movieGenre: UILabel = {
        let genre = UILabel()
        genre.textAlignment = .left
        genre.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        genre.text = "Comedy"
        return genre
    }()
    
    let releaseDate: UILabel = {
        let date = UILabel()
        date.textAlignment = .left
        date.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        date.text = "2020"
        return date
    }()
    
    let movieRate: CosmosView = {
        let rate = CosmosView()
        rate.settings.totalStars = 5
        rate.settings.emptyBorderColor = .yellow
        rate.settings.filledColor = .yellow
        rate.settings.fillMode = .half
        rate.settings.starSize = 17
        rate.settings.starMargin = 1
        return rate
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let containerView = UIView()
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(movieImageView)
        containerView.addSubview(stackView)
        movieImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.right.equalToSuperview().offset(-10)
            make.left.equalTo(movieImageView.snp.right).offset(10)
        }
        stackView.addArrangedSubview(movieName)
        stackView.addArrangedSubview(movieGenre)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(movieRate)
        
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}
