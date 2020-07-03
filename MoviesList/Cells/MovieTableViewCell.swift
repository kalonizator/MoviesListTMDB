//
//  MovieTableViewCell.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Variables init
    
    // MARK: - UI objects init
    
    lazy var thumbnailImageView: UIImageView = {
        let result = UIImageView()
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    lazy var movieName : UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.textColor = .black
        result.numberOfLines = 1
        result.adjustsFontSizeToFitWidth = true
        result.minimumScaleFactor = 0.3
        result.textAlignment = .left
        
        return result
    }()
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.sd_cancelCurrentImageLoad()
        thumbnailImageView.image = nil
        movieName.text?.removeAll()
    }
    
    // MARK: - Set up
    
    func setupViews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(movieName)
        
        setupLayout()
    }
    
    func setupLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        movieName.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.leading.equalTo(thumbnailImageView.snp.leading).offset(10)
            make.trailing.equalTo(thumbnailImageView.snp.trailing).offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - Actions
    
    func setData(movie: Movie) {
        thumbnailImageView.downloadImageWithBaseUrl(url: movie.posterPath, needBaseUrl: true)
        movieName.text = movie.name ?? "no movie name"
    }
    
}
