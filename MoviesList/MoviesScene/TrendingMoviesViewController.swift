//
//  TrendingMoviesViewController.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2019 kalonizator. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingMoviesViewController: UIViewController {
    private let viewModel: MoviesViewModel
        
    lazy var tableView: UITableView = {
        let result = UITableView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        result.rowHeight = UITableView.automaticDimension
        result.separatorStyle = .singleLine
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
    
    let searchController = UISearchController(searchResultsController: nil)

    private let searchTextField = UITextField()

    private let disposeBag = DisposeBag()
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
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
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Trending Movies"
        bindViewModel()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        rx.viewWillAppear
            .asObservable()
            .bind(to: viewModel.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asObservable()
            .bind(to: viewModel.selectedIndexSubject)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .asObservable()
            .bind(to: viewModel.searchQuerySubject)
            .disposed(by: disposeBag)

        
        viewModel.repos
            .drive(tableView.rx.items(cellIdentifier: "MovieTableViewCell", cellType: MovieTableViewCell.self)) { (row, element, cell) in
                cell.thumbnailImageView.downloadImageWithBaseUrl(url: element.imagePath, needBaseUrl: true)
                cell.movieNameLabel.text = element.name
            }
            .disposed(by: disposeBag)

        viewModel.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)

        viewModel.selectedMovieId
            .drive(onNext: { [weak self] movieId in
                guard let self = self else { return }
                let networkApi = NetworkingApi()
                self.navigationController?.pushViewController(MovieDetailesViewController(viewModel: ActorsViewModel(networkingService: networkApi, movieId: movieId), similarViewModel: SimilarMoviesViewModel(networkingService: networkApi, movieId: movieId), movieDetailsViewModel: MoviesDetailsViewModel(networkingService: networkApi, movieId: movieId)), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
