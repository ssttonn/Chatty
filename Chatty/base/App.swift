//
//  App.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation
import UIKit

final class App{
    static var shared = App()
    var window: UIWindow!
    var mainChatController: UIViewController!
    var loginViewController: UIViewController!
    
    func startInterface(isAuth: Bool) {
        mainChatController = UIStoryboard.main.mainChatViewController
       
            // MARK: Initial LoginViewController
            loginViewController = UIStoryboard.main.loginViewController
            
            if isAuth { // check whether user logged or not
                window?.rootViewController = mainChatController
            } else {
                window?.rootViewController = loginViewController
            }
            
            window?.makeKeyAndVisible()
        }
    
    func swipeLoginToMain() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            mainChatController.view.addSubview(snapShot)
        }
        window.rootViewController = mainChatController

        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
}
