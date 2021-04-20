//
//  RegUserViewController.swift
//  Buromotors
//
//  Created by Антон Редкозубов on 04.12.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit
import SnapKit

class RegUserViewController: UIViewController {
    
    private enum Constants {
        // TODO: - Adjust constants
        static var barViewHeight: CGFloat {
            switch UIScreen.deviceFamily {
            case .fifthFamily:
                return 60
            case .sixFamily, .plusFamily:
                return 60
            case .xFamily, .elevenFamily:
                return 90
            }
        }
        static var barViewTop: CGFloat {
            switch UIScreen.deviceFamily {
            case .fifthFamily:
                return 0
            case .sixFamily, .plusFamily:
                return 0
            case .xFamily, .elevenFamily:
                return 0
            }
        }
    }
    
    let athService = AthService()
    
    // MARK: - Subviews
    private lazy var barView: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        
        return uiview
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 17)
        
        return button
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Клиенты", at: 0, animated: false)
        segment.insertSegment(withTitle: "Самозанятный", at: 1, animated: false)
        segment.insertSegment(withTitle: "Автосеврис", at: 2, animated: false)
        segment.selectedSegmentIndex = 0
        
        return segment
    }()
    
    private lazy var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    private lazy var innSpace: UITextField = {
        let innField = UITextField()
        innField.placeholder = "Инн"
        innField.layer.cornerRadius = 10
        innField.borderStyle = .roundedRect
        
        return innField
    }()
    
    private lazy var nameSpace: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = "Имя"
        nameField.layer.cornerRadius = 10
        nameField.borderStyle = .roundedRect
        
        return nameField
    }()
    
    private lazy var lastNameSpace: UITextField = {
        let lastNameField = UITextField()
        lastNameField.placeholder = "Фамилия"
        lastNameField.layer.cornerRadius = 10
        lastNameField.borderStyle = .roundedRect
        
        return lastNameField
    }()
    
    
    private lazy var secondNameSpace: UITextField = {
        let secondNameField = UITextField()
        secondNameField.placeholder = "Отчество"
        secondNameField.layer.cornerRadius = 10
        secondNameField.borderStyle = .roundedRect
        
        return secondNameField
    }()
    
    private lazy var fioSpace: UITextField = {
        let fioField = UITextField()
        fioField.placeholder = "ФИО физ.лица или назв. Организации"
        fioField.layer.cornerRadius = 10
        fioField.borderStyle = .roundedRect
        
        return fioField
    }()
    
    private lazy var telephoneSpace: UITextField = {
        let telephoneField = UITextField()
        telephoneField.placeholder = "Телефон"
        telephoneField.layer.cornerRadius = 10
        telephoneField.borderStyle = .roundedRect
        
        return telephoneField
    }()
    
    private lazy var emailSpace: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.layer.cornerRadius = 10
        emailField.borderStyle = .roundedRect
        
        return emailField
    }()
    
    private lazy var passwordSpace: UITextField = {
        let passwordSpaceField = UITextField()
        passwordSpaceField.placeholder = "Пароль"
        passwordSpaceField.layer.cornerRadius = 10
        passwordSpaceField.borderStyle = .roundedRect
        
        return passwordSpaceField
    }()
    
    private lazy var secondPasswordSpace: UITextField = {
        let secondPassword = UITextField()
        secondPassword.placeholder = "Подтверждение пароля"
        secondPassword.layer.cornerRadius = 10
        secondPassword.borderStyle = .roundedRect
        
        return secondPassword
    }()
    
    private lazy var addressSpace: UITextField = {
        let adressNameField = UITextField()
        adressNameField.placeholder = "Адресс"
        adressNameField.layer.cornerRadius = 10
        adressNameField.borderStyle = .roundedRect
        
        return adressNameField
    }()
  
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var box: UIView = {
        let uiview = UIView()
        
        return uiview
    }()
    
    private var innSpaceH: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settupUi()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        regButton.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
        
        segmentedControl.addTarget(self, action:  #selector(segmentedControlTapped), for:.allEvents)
    }
    
    func settupUi() {
        view.backgroundColor = .white
        
        innSpace.layer.borderWidth = 1
        innSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        innSpace.layer.cornerRadius = 10
        innSpace.borderStyle = .none
        innSpace.clearButtonMode = .whileEditing
        
        nameSpace.layer.borderWidth = 1
        nameSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        nameSpace.layer.cornerRadius = 10
        nameSpace.borderStyle = .none
        nameSpace.clearButtonMode = .whileEditing
        
        lastNameSpace.layer.borderWidth = 1
        lastNameSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        lastNameSpace.layer.cornerRadius = 10
        lastNameSpace.borderStyle = .none
        lastNameSpace.clearButtonMode = .whileEditing
        
        secondNameSpace.layer.borderWidth = 1
        secondNameSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        secondNameSpace.layer.cornerRadius = 10
        secondNameSpace.borderStyle = .none
        secondNameSpace.clearButtonMode = .whileEditing
        
        fioSpace.layer.borderWidth = 1
        fioSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        fioSpace.layer.cornerRadius = 10
        fioSpace.borderStyle = .none
        fioSpace.clearButtonMode = .whileEditing
        
        telephoneSpace.layer.borderWidth = 1
        telephoneSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        telephoneSpace.layer.cornerRadius = 10
        telephoneSpace.borderStyle = .none
        telephoneSpace.clearButtonMode = .whileEditing
        
        emailSpace.layer.borderWidth = 1
        emailSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        emailSpace.layer.cornerRadius = 10
        emailSpace.borderStyle = .none
        emailSpace.clearButtonMode = .whileEditing
        
        passwordSpace.layer.borderWidth = 1
        passwordSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        passwordSpace.layer.cornerRadius = 10
        passwordSpace.borderStyle = .none
        passwordSpace.clearButtonMode = .whileEditing
        
        secondPasswordSpace.layer.borderWidth = 1
        secondPasswordSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        secondPasswordSpace.layer.cornerRadius = 10
        secondPasswordSpace.borderStyle = .none
        secondPasswordSpace.clearButtonMode = .whileEditing
        
        addressSpace.layer.borderWidth = 1
        addressSpace.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        addressSpace.layer.cornerRadius = 10
        addressSpace.borderStyle = .none
        addressSpace.clearButtonMode = .whileEditing
        
        
        innSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        nameSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        lastNameSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        secondNameSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        fioSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        telephoneSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        emailSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        passwordSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        secondPasswordSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        addressSpace.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    }

    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func regButtonTapped() {
        print(#function)
        
        if segmentedControl.selectedSegmentIndex == 2 {
            innSpace.placeholder = "ИНН(необязательно к заполнению)"
            guard let inn = innSpace.text, !inn.isEmpty else {
                showMassege(title: "Внимание!", massage: "Введите инн")
                return
            }
        } else if segmentedControl.selectedSegmentIndex == 1 {
            innSpace.placeholder = "ИНН"
        }
        
        guard let name = nameSpace.text, !name.isEmpty else {
           showMassege(title: "Внимание!", massage: "Введите имя")
           return
        }
        
        guard let lastName = lastNameSpace.text, !lastName.isEmpty else {
           showMassege(title: "Внимание!", massage: "Введите фамилию")
           return
        }
        
        guard let secondName = secondNameSpace.text, !secondName.isEmpty else {
           showMassege(title: "Внимание!", massage: "Введите отчество")
           return
        }
        
        guard let telephone = telephoneSpace.text, !telephone.isEmpty else {
           showMassege(title: "Внимание!", massage: "Введите номер телефона")
           return
        }
        
        guard let emailPlace = emailSpace.text, !emailPlace.isEmpty else {
           showMassege(title: "Внимание!", massage: "Введите отчество")
           return
        }
        
        guard let passwordPlace = passwordSpace.text, !passwordPlace.isEmpty else {
           showMassege(title: "Внимание!", massage: "Введите Пароль")
           return
        }
        
        guard let secondPassword = secondPasswordSpace.text, !secondPassword.isEmpty else {
            showMassege(title: "Внимание!", massage: "Введите Пароль еще раз")
            return
         }
        
        if secondPassword != passwordPlace {
            showMassege(title: "Внимание!", massage: "Пароль не совпадает")
            return
        }
        
        let firstName = nameSpace.text ?? ""
        let lastNameValue = lastNameSpace.text ?? ""
        let middleName = secondNameSpace.text ?? ""
        let address = addressSpace.text ?? ""
        let phone = telephoneSpace.text ?? ""
        let email = emailSpace.text ?? ""
        let fio = fioSpace.text ?? ""
        let password = passwordSpace.text ?? ""
        let rePassword = secondPasswordSpace.text ?? ""
        var inn: String?
        
        let type: ProfileType
        switch segmentedControl.selectedSegmentIndex {
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
        
        if password == rePassword {
            
            let userProfile = UserProfile(type: type, firstName: firstName, lastName: lastNameValue, middleName: middleName, name: fio, address: address, phone: phone, inn: inn, email: email, rawPassword: password)
            print("userProfile>rawPassword>", userProfile.rawPassword)
            
            athService.regstration(userProfile: userProfile,  password: password, rePassword: rePassword ) { [weak self] (state, error) in
                if state {
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.showMassege(title: "", massage: error.debugDescription)
                }
                
            }
        } else {
            self.showMassege(title: "", massage: "пароли не совпадают")
        }
    }
    
    @objc func segmentedControlTapped() {
        if segmentedControl.selectedSegmentIndex == 0 {
            innSpaceH?.update(offset: 0)
        } else {
            innSpaceH?.update(offset: 40)
        }
    }

    override func loadView() {
        super.loadView()
        
        view.addSubview(barView)
        barView.addSubview(closeButton)
        view.addSubview(segmentedControl)
        view.addSubview(regButton)
        view.addSubview(scrollView)
        scrollView.addSubview(box)
        box.addSubview(innSpace)
        box.addSubview(nameSpace)
        box.addSubview(lastNameSpace)
        box.addSubview(secondNameSpace)
        box.addSubview(fioSpace)
        box.addSubview(telephoneSpace)
        box.addSubview(emailSpace)
        box.addSubview(addressSpace)
        box.addSubview(passwordSpace)
        box.addSubview(secondPasswordSpace)
        
        
        barView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(Constants.barViewTop)
            $0.height.equalTo(Constants.barViewHeight)
        }
        
        closeButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.width.equalTo(90)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(barView.snp.bottom).offset(8)
        }
        
        regButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(45)
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(8)
            $0.bottom.equalTo(regButton.snp.top).offset(-8)
            $0.left.right.equalToSuperview()
        }
        
        box.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        innSpace.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            innSpaceH = $0.height.equalTo(0).constraint
            $0.top.equalTo(box).offset(10)
        }
        
        nameSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(innSpace.snp.bottom).offset(10)
        }
        
        lastNameSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(nameSpace.snp.bottom).offset(10)
        }
        
        secondNameSpace.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(lastNameSpace.snp.bottom).offset(10)
        }
        
        fioSpace.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(secondNameSpace.snp.bottom).offset(10)
        }
        
        telephoneSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(fioSpace.snp.bottom).offset(10)
        }
        
        emailSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(telephoneSpace.snp.bottom).offset(10)
        }
        
        
        addressSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(emailSpace.snp.bottom).offset(10)
        }
        
        passwordSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(addressSpace.snp.bottom).offset(10)
        }
        
        secondPasswordSpace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(passwordSpace.snp.bottom).offset(10)
            $0.bottom.equalTo(box).offset(-36)
        }
        
    }
    
    
    
}
