//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
        if !SavingManager.shared.getBoolValue("categortSelect") {
            let  onBoardingViewController = CountryViewController(nibName: "CountryViewController", bundle: nil)

            let navigationConteoller = UINavigationController(rootViewController: onBoardingViewController)
            navigationConteoller.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

            self.window?.rootViewController = navigationConteoller
            self.window?.makeKeyAndVisible()
        } else {
            //Mark go to topheading screen
            let  topHeadlineController = TopHeadLineViewController(nibName: "TopHeadLineViewController", bundle: nil)

            let navigationConteoller = UINavigationController(rootViewController: topHeadlineController)
            navigationConteoller.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

            self.window?.rootViewController = navigationConteoller
            self.window?.makeKeyAndVisible()
        }
      
        return true
    }


}

