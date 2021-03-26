//
//  InviaLoadingIndicator.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//


import UIKit
import NVActivityIndicatorView

class InviaLoadingIndicator {
    
    static let defaultAnimationType: NVActivityIndicatorType = .ballRotateChase
    
    static func show(animationType: NVActivityIndicatorType = defaultAnimationType) {
        let activityData = ActivityData(size: CGSize(width: 30, height: 30), message: nil, messageFont: nil, messageSpacing: nil, type:  animationType, color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear, textColor: nil)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    static func hide() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    static func showInSpecificView(view: UIView, animationType: NVActivityIndicatorType = defaultAnimationType) {
        
        HideFromSpecificView(view: view)
        
        let defaultFrame = CGRect(x: DeviceUsage.SCREEN_WIDTH/2, y: view.frame.size.height/2, width: 30, height: 30)
        let activityIndicatorView =  NVActivityIndicatorView(frame: defaultFrame, type: animationType,color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), padding: nil)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    static func HideFromSpecificView(view: UIView?) {
        guard let subViews = view?.subviews else {
            return
        }
        for subView in subViews {
            if subView is NVActivityIndicatorView {
                (subView as! NVActivityIndicatorView).stopAnimating()
                subView.removeFromSuperview()
            }
        }
    }
    
}
