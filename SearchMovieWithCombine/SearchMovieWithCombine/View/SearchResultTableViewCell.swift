//
//  SearchResultTableViewCell.swift
//  SearchMovieWithCombine
//
//  Created by J_Min on 2022/05/23.
//

import UIKit
import Combine

final class SearchResultTableViewCell: UITableViewCell {
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        
        return label
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.text = "releaseDate"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [thumbnailImageView, titleLabel, releaseLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(70)
        }
        
        releaseLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
    }
    
    public func configure(with movie: SearchMovieModel) {
        self.titleLabel.text = movie.title
        self.releaseLabel.text = movie.releaseDate
    }
}
