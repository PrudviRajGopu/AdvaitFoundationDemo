//
//  Loader.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 05/05/24.
//

import Foundation
import UIKit

extension UIView {
    
    // Activity Indicator
    func showActivityIndicator() {
            
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .black
        activityIndicator.tag = 111
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }

    
    func hideActivityIndicator() {

        let activityIndicator = self.viewWithTag(111) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        
    }
}
