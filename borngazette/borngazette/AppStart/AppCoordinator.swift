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
        let vc = GazetteViewController(nibName: nil, bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToArticle(article: ArticleViewController.Content) {
        let vc = ArticleViewController()
        vc.coordinator = self
        vc.build(data: article)
        navigationController.pushViewController(vc, animated: false)
    }
}
