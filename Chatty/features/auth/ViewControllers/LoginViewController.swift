//
//  LoginViewController.swift
//  Chatty
//
//  Created by GONOSEN on 10/08/2022.
//

import UIKit
import Lottie

class LoginViewController: BaseViewController {
    @IBOutlet weak var emailField: MainTextField!
    @IBOutlet weak var passwordField: MainTextField!
    @IBOutlet weak var loginSubmitBtn: MainButton!
    @IBOutlet weak var loginAnimationView: AnimationView!
    var loginWithEmailAndPasswordUC: LoginWithEmailAndPasswordUC = LoginWithEmailAndPasswordUC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoginTextFields()
        loginWithEmailAndPasswordUC.delegate = self
        loginSubmitBtn.layer.cornerRadius = BorderRadius.defaultRadius
        emailField.leftViewMode = .always
        passwordField.leftViewMode = .always
        emailField.text = "sstonn@gmail.com"
        passwordField.text = "abc123456"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loginAnimationView.initCustomBehavior()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text{
            loginWithEmailAndPasswordUC.call(params: LoginUsecaseParams(email: email, password: password))
        }
    }
}

extension LoginViewController: LoginUsecaseDelegate{
    func didLoginSuccessfully(_ loginManager: LoginWithEmailAndPasswordUC) {
        loginSubmitBtn.stopAnimation()
       
        if let chatViewController = UIStoryboard.main.instantiateViewController(withIdentifier: "MainChatViewController") as? MainChatViewController{
            navigationController?.viewControllers = [chatViewController]
        }
        
    }
    
    func onProgressing(_ loginManager: LoginWithEmailAndPasswordUC) {
        loginSubmitBtn.startAnimation()
    }
    
    func didFailWithError(_ loginManager: LoginWithEmailAndPasswordUC, error: Error) {
        loginSubmitBtn.stopAnimation()
    }
}

extension LoginViewController{
    func setUpLoginTextFields(){
        emailField.setLeftImage(withName: "email", withHeight: 30, withWidth: 30)
        passwordField.setLeftImage(withName: "password", withHeight: 30, withWidth: 30)
    }
}
