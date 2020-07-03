//
//  SearchBarNavViewController.swift
//  MoviesList
//
//  Created by Адилет on 7/2/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import UIKit

class SearchBarNavViewController: UIViewController {
    
    // MARK: - Constructor
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables init
    
    // MARK: - UI objects init
    
    lazy var searchBar: UISearchBar = {
        let result = UISearchBar()
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
//        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
    }
    
    deinit {
        
    }
    
    // MARK: - Set up
    
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    // MARK: - Network Manager calls
    
    // MARK: - Extensions
    
}

extension SearchBarNavViewController: UISearchBarDelegate {
    
    
    
}
