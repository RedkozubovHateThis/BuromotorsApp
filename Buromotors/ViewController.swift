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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                self?.showNextView()
            } else {
                self?.showMassege(title: "Внимание!", massage: error)
            }
        }
    }
    
    func showNextView() {
        print(#function)
        performSegue(withIdentifier: "showOrderslist", sender: nil)
    }
}

