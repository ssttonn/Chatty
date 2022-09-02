//
//  ViewController.swift
//  Chatty
//
//  Created by GONOSEN on 10/08/2022.
//

import UIKit
import Lottie

class WelcomeViewController: BaseViewController {
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideNavigationBar = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        loginButton.layer.cornerRadius = BorderRadius.defaultRadius
        registerButton.layer.cornerRadius = BorderRadius.defaultRadius
    }

    override func viewDidAppear(_ animated: Bool) {
        animationView.initCustomBehavior()
    }
    

}

