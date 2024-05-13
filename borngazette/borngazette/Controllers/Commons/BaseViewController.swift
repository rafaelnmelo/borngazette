//
//  BaseViewController.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit
//MARK: - CLASS -
class BaseViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

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

//MARK: - FUNCTIONS -
extension BaseViewController {
    func getAlert(title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title,
                                 message: message,
                                 preferredStyle: .alert)
    }
    
    func showAlert(title: String, message: String) {
        let alert = getAlert(title: title, message: message)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { (alert) in }))
        self.present(alert, animated: true, completion: nil)
    }
}
