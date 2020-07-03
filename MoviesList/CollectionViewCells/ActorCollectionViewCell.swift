//
//  ActorCollectionViewCell.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator corp. All rights reserved.
//

import UIKit
import SnapKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables init
    
    // MARK: - UI objects init
    
    lazy var actorImageView: UIImageView = {
        let result = UIImageView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.clipsToBounds = true
        result.contentMode = .scaleAspectFill
        
        return result
    }()
    
    lazy var actorNameLabel : UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Set up
    
    func setupViews() {
        addSubview(actorImageView)
        addSubview(actorNameLabel)
        
        setupLayout()
    }
    
    func setupLayout() {
        actorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(120)
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - Actions
    
}
