//
//  BaseTabBarViewController.swift
//  BornGazette
//
//  Created by Rafael Melo on 14/05/24.
//

import UIKit

//MARK: - CLASS -
class BaseTabBarViewController: UITabBarController {
    
    var coordinator: AppCoordinator?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
