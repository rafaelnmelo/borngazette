//
//  ActivityIndicatorView.swift
//  BornGazette
//
//  Created by Rafael Melo on 14/05/24.
//

import UIKit

class ActivityIndicatorView {
    
    static var vSpinner : UIView?
    
    class func showActivityIndicatorView(onView : UIView) {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.clear
        let blackView = UIView.init(frame: UIScreen.main.bounds)
        blackView.alpha = 0.3
        blackView.backgroundColor = .black
        spinnerView.addSubview(blackView)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        ai.color = .white
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            vSpinner = spinnerView
        }
    }
    
    class func removeActivityIndicatorView() {
       DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
