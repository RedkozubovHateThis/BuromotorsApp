//
//  MyProfileViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 30.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class UserPropertys {
    let title: String
    let value: String
    init(title: String, value: String) {
        self.value = value
        self.title = title
    }
}

protocol MyProfileViewControllerDelegate: AnyObject {
    func exitMyProfile(name: String)
}

class MyProfileViewController: UIViewController {
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var middleNameTF: UITextField!
    @IBOutlet var fullNameTF: UITextField!
    @IBOutlet var adressTF: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var innTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bordView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var myProfile: UserProfile?
    var myUser: UserInfo?
    
    var profileService: ProfileService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileService = ProfileService.shared
        
        makeUi()
    }
    
    func makeUi() {
        myProfile = ProfileService.shared.myProfile
        myUser = ProfileService.shared.myUser
        
        
        firstNameTF.text = myUser?.firstName
        lastNameTF.text = myUser?.lastName
        middleNameTF.text = myUser?.middleName
        fullNameTF.text = myProfile?.name
        adressTF.text = myProfile?.address
        emailTextField.text = myProfile?.email
        phoneTextField.text = myProfile?.phone
        innTextField.text = myProfile?.inn

        firstNameTF.layer.borderWidth = 0.5
        firstNameTF.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        firstNameTF.layer.cornerRadius = 5
        
        lastNameTF.layer.borderWidth = 0.5
        lastNameTF.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        lastNameTF.layer.cornerRadius = 5
        
        middleNameTF.layer.borderWidth = 0.5
        middleNameTF.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        middleNameTF.layer.cornerRadius = 5
        
        fullNameTF.layer.borderWidth = 0.5
        fullNameTF.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        fullNameTF.layer.cornerRadius = 5
        
        adressTF.layer.borderWidth = 0.5
        adressTF.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        adressTF.layer.cornerRadius = 5
        
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        emailTextField.layer.cornerRadius = 5
        
        phoneTextField.layer.borderWidth = 0.5
        phoneTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        phoneTextField.layer.cornerRadius = 5
        
        innTextField.layer.borderWidth = 0.5
        innTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        innTextField.layer.cornerRadius = 5
        
        saveButton.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        saveButton.layer.cornerRadius = 5
        saveButton.isHidden = true
        

        
        scrollView.contentSize = CGSize(width: CGFloat(100), height:CGFloat(2000))
        print("scrollView.contentSize.width>",scrollView.contentSize.width)
    }
    
    @IBAction func tapExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapActiveEdit(_ sender: Any) {
        let token = TokenService.shared.access_token
        
        if firstNameTF.isEnabled {
            firstNameTF.isEnabled = false
            lastNameTF.isEnabled = false
            middleNameTF.isEnabled = false
            fullNameTF.isEnabled = false
            adressTF.isEnabled = false
            emailTextField.isEnabled = false
            phoneTextField.isEnabled = false
            innTextField.isEnabled = false
            saveButton.isHidden = true
            exitButton.isHidden = false
        } else {
            firstNameTF.isEnabled = true
            lastNameTF.isEnabled = true
            middleNameTF.isEnabled = true
            fullNameTF.isEnabled = true
            adressTF.isEnabled = true
            emailTextField.isEnabled = true
            phoneTextField.isEnabled = true
            innTextField.isEnabled = true
            saveButton.isHidden = false
            exitButton.isHidden = true
        }
        

    }
    @IBAction func loguout(_ sender: Any) {
        TokenService.shared.access_token = ""
        TokenService.shared.refresh_token = ""
        
        OrderService.shared.serviceDocuments.removeAll()
        
        performSegue(withIdentifier: "goLogin", sender: nil)

    }
    
    @IBAction func tapSaveMyProfile(_ sender: Any) {
        print(#function)
        guard let myProfile = myProfile  else { return }
        guard let myUser = myUser else { return }
        let token = TokenService.shared.access_token
        
        print(myProfile.name)
        // myUser
        myUser.firstName = firstNameTF.text ?? ""
        myUser.lastName = lastNameTF.text ?? ""
        myUser.middleName = middleNameTF.text ?? ""
        
        // myProfile
        myProfile.name = fullNameTF.text ?? ""
        myProfile.email = emailTextField.text ?? ""
        myProfile.address = adressTF.text ?? ""
        myProfile.phone = phoneTextField.text ?? ""
        myProfile.inn = innTextField.text ?? ""
        
        profileService?.saveMyProfile(token: token, userProfile: myProfile, completion: { (state, error) in
            
        })
        
        profileService?.saveMyUser(token: token, userInfo: myUser, userProfile: myProfile , completion:  {(state, error) in
        
    })
    }
    
    
}
