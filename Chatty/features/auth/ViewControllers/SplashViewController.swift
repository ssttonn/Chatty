//
//  SplashViewController.swift
//  Chatty
//
//  Created by sstonn on 27/08/2022.
//

import UIKit

class SplashViewController: UIViewController {
    var checkForAuthUC: CheckForAuthUC = CheckForAuthUC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForAuthUC.delegate = self
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
            self.checkForAuthUC.call(params: NoParam())
            timer.invalidate()
        }
    }
}

//MARK: Handle UC delegate methods
extension SplashViewController: CheckForAuthUsecaseDelegate{
    func didChangeAuthState(_ host: CheckForAuthUC, loggedIn: Bool) {
        if loggedIn{
            if let chatViewController = UIStoryboard.main.instantiateViewController(withIdentifier: "MainChatViewController") as? MainChatViewController{
                navigationController?.viewControllers = [chatViewController]
            }
            return
        }
        if let welcomeViewController = UIStoryboard.main.instantiateViewController(withIdentifier: "WelcomeViewController") as? MainChatViewController{
            navigationController?.viewControllers = [welcomeViewController]
        }
    }
}
