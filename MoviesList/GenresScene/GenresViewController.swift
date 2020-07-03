//
//  GenresViewController.swift
//  MoviesList
//
//  Created by Адилет on 7/2/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import UIKit
import UIKit
import RxSwift
import RxCocoa

class GenresViewController: UIViewController {
    private let viewModel: GenresViewModel
        
    lazy var tableView: UITableView = {
        let result = UITableView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.register(GenresTableViewCell.self, forCellReuseIdentifier: "GenresTableViewCell")
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
    
    private let searchTextField = UITextField()

    private let disposeBag = DisposeBag()
    
    init(viewModel: GenresViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        definesPresentationContext = false
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
        
        viewModel.repos
            .drive(tableView.rx.items(cellIdentifier: "GenresTableViewCell", cellType: GenresTableViewCell.self)) { (row, element, cell) in
                cell.genreNameLabel.text = element.name
            }
            .disposed(by: disposeBag)

        viewModel.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)

        viewModel.selectedGenreId
            .drive(onNext: { [weak self] genreId in
                guard let self = self else { return }
            })
            .disposed(by: disposeBag)
    }
}
