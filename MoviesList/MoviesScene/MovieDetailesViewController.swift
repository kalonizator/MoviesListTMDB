//
//  MovieDetailesViewController.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator corp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailesViewController: UIViewController, UIScrollViewDelegate {
    
    private let movieDetailsViewModel: MoviesDetailsViewModel
    private let actorsViewModel: ActorsViewModel
    private let similarViewModel: SimilarMoviesViewModel
    
    lazy var scrollView: UIScrollView = {
        let result = UIScrollView()
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    lazy var contentView: UIView = {
        let result = UIView()
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    lazy var posterImageViewHeightAnchor = posterImageView.heightAnchor.constraint(equalToConstant: 0)
    lazy var posterImageView: UIImageView = {
        let result = UIImageView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentMode = .scaleAspectFit
        
        return result
    }()
    
    lazy var tableView: UITableView = {
        let result = UITableView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        result.rowHeight = UITableView.automaticDimension
        result.separatorStyle = .none
        result.sizeToFit()
        result.tableFooterView = UIView()
        result.backgroundColor = .white
        result.tableHeaderView = UIView()
        result.estimatedRowHeight = UITableView.automaticDimension
        // Similarly, you can set for header & footer
        result.sectionFooterHeight = UITableView.automaticDimension
        result.sectionHeaderHeight = UITableView.automaticDimension
        result.estimatedSectionFooterHeight = 0
        result.estimatedSectionHeaderHeight = 0
        result.showsVerticalScrollIndicator = true
        result.showsHorizontalScrollIndicator = false
        result.bounces = true
        result.isUserInteractionEnabled = true
        result.isScrollEnabled = true
        
        return result
    }()
    lazy var tableViewHeightAnchor = tableView.heightAnchor.constraint(equalToConstant: 0)
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        let result = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        result.setCollectionViewLayout(flowLayout, animated: true)
        result.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: "ActorCollectionViewCell")
        result.bounces = false
        result.isPagingEnabled = false
        result.backgroundColor = .clear
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    lazy var descriptionLabel : UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.numberOfLines = 0
        result.adjustsFontSizeToFitWidth = true
        result.minimumScaleFactor = 0.3
        result.textAlignment = .left
        
        return result
    }()
    
    lazy var similarMoviesTitleLabel : UILabel = {
         let result = UILabel()
         result.translatesAutoresizingMaskIntoConstraints = false
         result.numberOfLines = 0
         result.adjustsFontSizeToFitWidth = true
         result.minimumScaleFactor = 0.3
         result.textAlignment = .left
         result.text = "Similar titles"
         result.font = UIFont.systemFont(ofSize: 20, weight: .bold)

         return result
     }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private let searchTextField = UITextField()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: ActorsViewModel, similarViewModel: SimilarMoviesViewModel, movieDetailsViewModel: MoviesDetailsViewModel) {
        self.actorsViewModel = viewModel
        self.similarViewModel = similarViewModel
        self.movieDetailsViewModel = movieDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        definesPresentationContext = false
        
        searchController.searchResultsUpdater = nil
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Movie details"
        bindViewModel()
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(tableView)
        contentView.addSubview(collectionView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(similarMoviesTitleLabel)
        
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
        }
        posterImageViewHeightAnchor.isActive = true
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(150)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        similarMoviesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        tableViewHeightAnchor.isActive = true
        tableView.snp.makeConstraints { make in
            make.top.equalTo(similarMoviesTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewHeightAnchor.constant = tableView.contentSize.height
        if posterImageView.frame.size.width < (posterImageView.image?.size.width ?? 0) {
            posterImageViewHeightAnchor.constant = posterImageView.frame.size.width / (posterImageView.image?.size.width ?? 0) * (posterImageView.image?.size.height ?? 0)
        }
    }
    
    private func bindViewModel() {
        rx.viewWillAppear
            .asObservable()
            .bind(to: actorsViewModel.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        rx.viewWillAppear
            .asObservable()
            .bind(to: similarViewModel.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        rx.viewWillAppear
            .asObservable()
            .bind(to: movieDetailsViewModel.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asObservable()
            .bind(to: similarViewModel.selectedIndexSubject)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .asObservable()
            .bind(to: actorsViewModel.selectedIndexSubject)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        actorsViewModel.actors
            .drive(collectionView.rx.items(cellIdentifier: "ActorCollectionViewCell", cellType: ActorCollectionViewCell.self)) { (row, element, cell) in
                cell.actorNameLabel.text = element.name
                cell.actorImageView.downloadImageWithBaseUrl(url: element.actorAvatarPath, needBaseUrl: true)
        }
        .disposed(by: disposeBag)
        
        similarViewModel.movie
            .drive(tableView.rx.items(cellIdentifier: "MovieTableViewCell", cellType: MovieTableViewCell.self)) { (row, element, cell) in
                cell.movieNameLabel.text = element.name
                cell.thumbnailImageView.downloadImageWithBaseUrl(url: element.imagePath, needBaseUrl: true)
        }
        .disposed(by: disposeBag)
        
        movieDetailsViewModel.movie.drive(onNext: { [weak self] movie in
            guard let self = self else { return }
            self.posterImageView.downloadImageWithBaseUrl(url: movie.imagePath, needBaseUrl: true)
            self.descriptionLabel.text = movie.description
        }).disposed(by: disposeBag)
        
        actorsViewModel.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        similarViewModel.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        actorsViewModel.selectedActorId
            .drive(onNext: { [weak self] movieId in
                guard let self = self else { return }
            })
            .disposed(by: disposeBag)
        
    }
}

extension MovieDetailesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.bounds.size.width/2)
        let height = 175
        return CGSize( width: width , height: height )
    }
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return CGFloat(10)
    //    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 15, right: 0)
    }
}
