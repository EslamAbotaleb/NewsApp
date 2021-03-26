//
//  ViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("calledViewController")
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let  onBoardingViewController = CountryViewController(nibName: "CountryViewController", bundle: nil)

            let navigationConteoller = UINavigationController(rootViewController: onBoardingViewController)
            navigationConteoller.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

            self.present(navigationConteoller, animated: true, completion: nil)

        }
    }


}

