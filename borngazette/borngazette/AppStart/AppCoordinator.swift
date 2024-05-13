//
//  AppCoordinator.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: BaseNavigationController { get set }
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBar = BaseTabBarViewController()
        tabBar.coordinator = self
        
        let gazetteVC = GazetteViewController(nibName: nil, bundle: nil)
        gazetteVC.coordinator = self
        let readLaterVC = ReadLaterViewController(nibName: nil, bundle: nil)
        readLaterVC.coordinator = self
        
        let firstVC = UINavigationController(rootViewController: gazetteVC)
        let secondVC = UINavigationController(rootViewController: readLaterVC)
        
        firstVC.tabBarItem = UITabBarItem(title: "Manchetes", image: UIImage(systemName: "house"),selectedImage: UIImage(systemName: "house.fill"))
        secondVC.tabBarItem = UITabBarItem(title: "Ler Depois", image: UIImage(systemName: "bookmark"),selectedImage: UIImage(systemName: "bookmark.fill"))

        tabBar.viewControllers = [firstVC, secondVC]

        navigationController.pushViewController(tabBar, animated: false)
    }
    
    func goToArticle(article: Article) {
        let vc = ArticleViewController()
        vc.coordinator = self
        vc.build(data: article)
        navigationController.pushViewController(vc, animated: false)
    }
}
