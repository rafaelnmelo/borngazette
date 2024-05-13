//
//  BaseNavigationController.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit
//MARK: - CLASS -
class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavbar()
        navigationBar.prefersLargeTitles = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
//MARK: - FUNCTIONS -
extension BaseNavigationController {
    
    func setNavbar() {
        ///Cor do title normal
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.titleTextAttributes = textAttributes
        
        ///Cor para largeTitle
        let largeTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.largeTitleTextAttributes = largeTextAttributes
        
        ///Barra transparente
        self.navigationBar.isTranslucent = true
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = textAttributes
            appearance.largeTitleTextAttributes = largeTextAttributes
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
        }
        
        setBackButton()
    }
    
    func setBackButton() {
        ///Title transparente
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes(textAttributes, for: .normal)
        appearance.setTitleTextAttributes(textAttributes, for: .highlighted)
        ///Icone de voltar na mesma cor do title na navBar
        appearance.tintColor = .white
        
        if #available(iOS 15, *) {
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = textAttributes
            buttonAppearance.highlighted.titleTextAttributes = textAttributes
            self.navigationBar.standardAppearance.backButtonAppearance = buttonAppearance
            self.navigationBar.scrollEdgeAppearance?.backButtonAppearance = buttonAppearance
        }
    }
}
