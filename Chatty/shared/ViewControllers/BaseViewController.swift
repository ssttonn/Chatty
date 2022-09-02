//
//  BaseViewController.swift
//  Chatty
//
//  Created by GONOSEN on 12/08/2022.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate{
    var shouldHideNavigationBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupCustomAppBar()
    }
    
}

extension BaseViewController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is BaseViewController{
            navigationController.setNavigationBarHidden((viewController as! BaseViewController).shouldHideNavigationBar, animated: true)
        }
    }
}

extension BaseViewController{
    func setupCustomAppBar(){
        //MARK: - Set title attributes
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SVN-Kelson Sans", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.primaryColor ]
        
        //MARK: - Set back button UI and behavior
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(popViewController), imageName: "back")
        navigationItem.leftBarButtonItem?.tintColor = UIColor.primaryColor
    }
    
    @objc func popViewController(){
        navigationController?.popViewController(animated: true)
    }
}
