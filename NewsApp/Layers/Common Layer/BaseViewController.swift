//
//  BaseViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit
import Toast_Swift
class BaseViewController: UIViewController {
    var containerView:UIView!

    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .white
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.15) {
            self.containerView.alpha = 0.8
        }
        
        let activivtyIndicator = UIActivityIndicatorView(style: .gray)
        containerView.addSubview(activivtyIndicator)
        
        activivtyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activivtyIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activivtyIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activivtyIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Show Error Appear
    func showErrorView(errorTitle: String, errorDescription: String) {
        self.view.endEditing(true)
        var style = ToastStyle()
        style.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        style.messageColor = UIColor.white
        style.messageAlignment = .right
        self.view.makeToast(errorDescription, duration: 4.0,position: .bottom, style: style)
    }
    
    //MARK:- NavgationBar In The Case menu Button
    func intialnavigationBarAppearaceWithmenu(checkflag: Bool = true) {

        self.navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().isTranslucent = false
        
        let titleNews = UILabel()
        titleNews.frame = CGRect(x: 0, y: 0, width: 15, height: 15)

        //titleMenuKolYoumAya.font = UIFont(name: "Monadi", size: 20)
//        titleMenuKolYoumAya.font = UIFont.systemFont(ofSize: 20.0)
//        titleMenuKolYoumAya.font = UIFont.boldSystemFont(ofSize: 20.0)
       //GE SS Two

        titleNews.text = "News"

        titleNews.textColor = UIColor.black
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("Next", for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        btn1.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        let item1 = UIBarButtonItem(customView: btn1)
//             anothericonMenu.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        
        
//        if Localizer.isArabic() {
//            self.navigationItem.setLeftBarButtonItems([buttonBar, anotherbuttonBar], animated: true)
//
//        } else {
            self.navigationItem.setRightBarButton(item1, animated: true)
//        }
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.barTintColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK:- Appear View Controler Without Menu Button
    func intialNavigationBarWithoutUsemenu() {
        self.navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().isTranslucent = false
        let backButton = UIButton(type: .custom)
        
        backButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        if Localizer.isArabic() {
            backButton.setImage(UIImage(named: "icons8-back-50"), for: .normal)
        } else {
            backButton.setImage(UIImage(named: "icons8-back-50"), for: .normal)
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    }
    
    
    @objc func toggleMenu() {
        print("pressed")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
