//
//  TabbarViewController.swift
//  MoviesList
//
//  Created by Адилет on 7/2/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let movieViewModel = MoviesViewModel(networkingService: NetworkingApi())
        let discoverVC = createNavController(vc: TrendingMoviesViewController(viewModel: movieViewModel), selected: UIImage(named: "discover_icon_pdf")!, unselected: UIImage(named: "discover_icon_pdf")!)
        
        let genresViewModel = GenresViewModel(networkingService: NetworkingApi())
        let genresVC = createNavController(vc: GenresViewController(viewModel: genresViewModel), selected: UIImage(named: "genre_icon_pdf")!, unselected: UIImage(named: "genre_icon_pdf")!)
        
        viewControllers = [discoverVC, genresVC]
        
        var sidePadding : CGFloat = 4

        if hasTopNotch {
            sidePadding = 10
        }
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: sidePadding, left: 0, bottom: -(sidePadding), right: 0)
        }
    }
}

extension UITabBarController {
    
    func createNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        return navController
    }
    
}
