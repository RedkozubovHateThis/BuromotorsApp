//
//  RegistrationViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 18.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet var segmentOutlet: UISegmentedControl!
    @IBOutlet var innSpace: UITextField!
    @IBOutlet var lastNameSpace: UITextField!
    @IBOutlet var firstNameSpace: UITextField!
    @IBOutlet var secondNameSpace: UITextField!
    @IBOutlet var fullNameOrganizationSpace: UITextField!
    @IBOutlet var phoneSpace: UITextField!
    @IBOutlet var emailSpace: UITextField!
    @IBOutlet var adressSpace: UITextField!
    @IBOutlet var passwordSpace: UITextField!
    @IBOutlet var secondPasswordSpace: UITextField!
    @IBOutlet var userName: UITextField!
    
    let athService = AthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiPharams()
    }
    
    func uiPharams() {
        innSpace.isHidden = true
//        innSpace.placeholder = "ИНН"
        
        lastNameSpace.placeholder = "Фамилия"
        firstNameSpace.placeholder = "Имя"
        secondNameSpace.placeholder = "Отчество"
        fullNameOrganizationSpace.placeholder = "ФИО физ.лица или назв. Организации"
        phoneSpace.placeholder = "Телефон"
        emailSpace.placeholder = "Email"
        adressSpace.placeholder = "Адрес"
        passwordSpace.placeholder = "Пароль"
        secondPasswordSpace.placeholder = "Подтверждение пароля"
        userName.placeholder = "Username"
        
        segmentOutlet.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        segmentOutlet.tintColor = .white
        
        let titleTextAttributesTitn = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentOutlet.setTitleTextAttributes(titleTextAttributesTitn, for:.normal)
        
        let titleTextAttributesBack = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentOutlet.setTitleTextAttributes(titleTextAttributesBack, for:.selected)
        
        innSpace.layer.borderWidth = 0.5
        innSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        innSpace.layer.cornerRadius = 10
        
        userName.layer.borderWidth = 0.5
        userName.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        userName.layer.cornerRadius = 10
        
        lastNameSpace.layer.borderWidth = 0.5
        lastNameSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        lastNameSpace.layer.cornerRadius = 10
        
        firstNameSpace.layer.borderWidth = 0.5
        firstNameSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        firstNameSpace.layer.cornerRadius = 10
        
        secondNameSpace.layer.borderWidth = 0.5
        secondNameSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        secondNameSpace.layer.cornerRadius = 10
        
        fullNameOrganizationSpace.layer.borderWidth = 0.5
        fullNameOrganizationSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        fullNameOrganizationSpace.layer.cornerRadius = 10
        
        phoneSpace.layer.borderWidth = 0.5
        phoneSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        phoneSpace.layer.cornerRadius = 10
        
        emailSpace.layer.borderWidth = 0.5
        emailSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        emailSpace.layer.cornerRadius = 10
        
        adressSpace.layer.borderWidth = 0.5
        adressSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        adressSpace.layer.cornerRadius = 10
        
        passwordSpace.layer.borderWidth = 0.5
        passwordSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        passwordSpace.layer.cornerRadius = 10
        
        secondPasswordSpace.layer.borderWidth = 0.5
        secondPasswordSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        secondPasswordSpace.layer.cornerRadius = 10
    }
    
    @IBAction func tapSave(_ sender: Any) {
    
        let firstName = firstNameSpace.text ?? ""
        let lastName = lastNameSpace.text ?? ""
        let middleName = secondNameSpace.text ?? ""
        let address = adressSpace.text ?? ""
        let phone = phoneSpace.text ?? ""
        let email = emailSpace.text ?? ""
        let userN = userName.text ?? ""
        var inn: String?
        
        let type: ProfileType
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            type = ProfileType.CLIENT
        case 1:
            type = ProfileType.FREELANCER
            if let textinn = innSpace.text, textinn.count > 10 {
                inn = innSpace.text
            }
        case 2:
            type = ProfileType.SERVICE_LEADER
            inn = innSpace.text
        default :
            type = ProfileType.CLIENT
        }
        
//        let userProfile = UserProfile(type: type, firstName: firstName, lastName: lastName, middleName: middleName, name: userN, address: address, phone: phone, inn: inn, email: email)
//
        let password = "12345678"
        let rePassword = "12345678"
        
//        athService.regstration(userProfile: userProfile,  password: password, rePassword: rePassword ) { (state, error) in
//            print("athService>state>", state)
//        }
    }
    
    @IBAction func changeSegments() {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            innSpace.isHidden = true
        case 1:
            innSpace.isHidden = false
            innSpace.placeholder = "ИНН (необязательно к заполнения)"
            
        case 2:
            innSpace.isHidden = false
            innSpace.placeholder = "ИНН"
        default: break
        }
    }
    
    @IBAction func exitButtonPress() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
}
