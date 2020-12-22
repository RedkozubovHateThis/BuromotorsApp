//
//  ViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 09.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {
    @IBOutlet var loginForm: UITextField!
    @IBOutlet var passwordForm: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registrationButton: UIButton!
    
    let athService = AthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUi()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("TokenService.shared.access_token>", TokenService.shared.access_token)
        
        let refreshToken = TokenService.shared.refresh_token
        
        if !refreshToken.isEmpty {
            athService.refreshAccessToken(refreshToken: refreshToken) { (success, error) in
                if success {
                    let token = TokenService.shared.access_token
                    self.loadMyProfile(token: token)
                }
            }
        }
        
//        let token = TokenService.shared.access_token
//        self.loadMyProfile(token: token)
    }
    
    func createUi() {
//        loginForm.textColor = .
        loginButton.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        loginButton.layer.cornerRadius = 10
        
        registrationButton.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        registrationButton.layer.cornerRadius = 10
        
        loginForm.layer.borderWidth = 1
        loginForm.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        loginForm.layer.cornerRadius = 10
        
        passwordForm.layer.borderWidth = 1
        passwordForm.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        passwordForm.layer.cornerRadius = 10
    }
    
    @IBAction func registratonButPress() {
        print(#function)
        let regUserViewController = RegUserViewController()
        
        regUserViewController.modalPresentationStyle = .fullScreen
        
        self.present(regUserViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginPres() {
        let athService = AthService()

        
        guard  let login = loginForm.text, let password = passwordForm.text else { return }
        if !login.isEmpty && !password.isEmpty {
            athService.ath(username: login, password: password) { [weak self] (success, error) in
                if success {
                    self?.loadMyProfile(token: TokenService.shared.access_token)
                } else {
                    self?.showMassege(title: "Внимание!", massage: error)
                }
            }
        }
        
    }
    
    func loadMyProfile(token: String) {
        ProfileService.shared.loadMyProfile(token: token) { [weak self] (success, error) in
            if success {
                self?.loadAdvertisings()
            } else {
                self?.showMassege(title: "Внимание!", massage: error)
            }
        }
    }
    
    
    func loadAdvertisings() {
        let token = TokenService.shared.access_token
        AdvertisingService.shared.loadAdvertising(token: token) { [weak self] (state, error) in
            self?.showNextView()
        }
    
    }
    
    func showNextView() {
        print(#function)
        performSegue(withIdentifier: "showOrderslist", sender: nil)
    }
}

