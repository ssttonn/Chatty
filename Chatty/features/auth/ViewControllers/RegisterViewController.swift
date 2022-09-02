//
//  RegisterViewController.swift
//  Chatty
//
//  Created by GONOSEN on 12/08/2022.
//

import UIKit
import Lottie

class RegisterViewController: BaseViewController {
    @IBOutlet weak var registerAnimationView: AnimationView!
    @IBOutlet weak var registerSubmitBtn: MainButton!
    @IBOutlet weak var userNameTextField: MainTextField!
    @IBOutlet weak var emailTextField: MainTextField!
    @IBOutlet weak var passwordTextField: MainTextField!
    var registerUC = RegisterUC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRegisterTextFields()
        registerUC.delegate = self
        registerSubmitBtn.layer.cornerRadius = BorderRadius.defaultRadius
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerAnimationView.initCustomBehavior()
    }
    
    @IBAction func onRegisterButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, let username = userNameTextField.text{
            registerUC.call(params: RegisterUCParams(email: email, password: password, username: username))
        }
    }
}

extension RegisterViewController: RegisterUCDelegate{
    func didRegisterSuccessfully(_ host: RegisterUC) {
        registerSubmitBtn.stopAnimation()
    }
    
    func onProgressing(_ host: RegisterUC) {
        registerSubmitBtn.startAnimation()
    }
    
    func didFailWithError(_ host: RegisterUC, error: Error) {
        registerSubmitBtn.stopAnimation()
    }
}

extension RegisterViewController{
    func setUpRegisterTextFields(){
        userNameTextField.setLeftImage(withName: "man", withHeight: 30, withWidth: 30)
        emailTextField.setLeftImage(withName: "email", withHeight: 30, withWidth: 30)
        passwordTextField.setLeftImage(withName: "password", withHeight: 30, withWidth: 30)
    }
}
