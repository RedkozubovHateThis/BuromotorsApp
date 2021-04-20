//
//  OrdersDetailsViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 16.12.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit
import SnapKit


class OrdersDetailsViewController: UIViewController {
    
    
    private enum Constants {
        // TODO: - Adjust constants
        static var barViewHeight: CGFloat {
            switch UIScreen.deviceFamily {
            case .fifthFamily:
                return 60
            case .sixFamily, .plusFamily:
                return 60
            case .xFamily, .elevenFamily:
                return 80
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
    
    var myOrder: ServiceDocument?
    var myVehicle: Vehicle?
    var myVehicleMileage: VehicleMileage?
    var myCustomer: Customer?
    var orderService: OrderService?
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var box: UIView = {
        let uiview = UIView()
        
        return uiview
    }()
    
    private lazy var documentStatusLabel: UILabel = {
        let statusText = UILabel()
        statusText.text = "Состояние"
        
        return statusText
    }()
    
    private lazy var documentStatusTextField: UITextField = {
        let docStatusField = UITextField()
        
        docStatusField.isEnabled = false
        docStatusField.borderStyle = .roundedRect
        
        if let documentStatus = myOrder?.status {
            if documentStatus == .complited {
                docStatusField.text = "Оформлен"
            }
            if documentStatus == .created {
                docStatusField.text = "Заявка"
            }
            if documentStatus == .inWork {
                docStatusField.text = "В работе"
            }
        }
        return docStatusField
    }()
    
    private lazy var paidStatusLabel: UILabel = {
        let paidText = UILabel()
        paidText.text = "Статус оплаты"
        
        return paidText
    }()
    
    private lazy var paidStatusTextField: UITextField = {
        let paidStatusField = UITextField()
        
        paidStatusField.isEnabled = false
        paidStatusField.borderStyle = .roundedRect
        
        if let paidStatus = myOrder?.paidStatus {
            if paidStatus == .paid {
                paidStatusField.text = "Оплачен"
            }
            if paidStatus == .notPaid {
                paidStatusField.text = "Не оплачен"
            }
        }
        
        return paidStatusField
    }()
    
    private lazy var remontStartLabel: UILabel = {
        let remontStartText = UILabel()
        remontStartText.text = "Дата начала ремонта:"
        
        return remontStartText
    }()
    
    private lazy var remontStartTextField: UITextField = {
        let remontStartField = UITextField()
        
        remontStartField.isEnabled = false
        remontStartField.borderStyle = .roundedRect
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd.MM.yyyy hh:mm"
        remontStartField.text = formatter3.string(from: myOrder?.startDate ?? Date())
        
        return remontStartField
        }()
    
    private lazy var carModelLabel: UILabel = {
        let carModelText = UILabel()
        carModelText.text = "Марка/модель:"
        
        return carModelText
    }()
    
    private lazy var carModelTextField: UITextField = {
        let carModelField = UITextField()
        
        carModelField.isEnabled = false
        carModelField.borderStyle = .roundedRect
        carModelField.text = myVehicle?.modelName
        
        return carModelField
        }()
    
    private lazy var regNumberLabel: UILabel = {
        let regNumberText = UILabel()
        regNumberText.text = "Регистрационный номер:"
        
        return regNumberText
    }()
    
    private lazy var regNumberTextField: UITextField = {
        let regNumberField = UITextField()
        
        regNumberField.isEnabled = false
        regNumberField.borderStyle = .roundedRect
        regNumberField.text = myVehicle?.regNumber
        
        return regNumberField
        }()
    
    private lazy var vinNumberLabel: UILabel = {
        let vinNumberText = UILabel()
        vinNumberText.text = "VIN - номер:"
        
        return vinNumberText
    }()
    
    private lazy var vinNumberTextField: UITextField = {
        let vinNumberField = UITextField()
        
        vinNumberField.isEnabled = false
        vinNumberField.borderStyle = .roundedRect
        vinNumberField.text = myVehicle?.vinNumber
        
        return vinNumberField
        }()
    
    private lazy var myVehicleMileageLabel: UILabel = {
        let myVehicleMileageText = UILabel()
        myVehicleMileageText.text = "Пробег:"
        
        return myVehicleMileageText
    }()
    
    private lazy var myVehicleMileageTextField: UITextField = {
        let myVehicleMileageField = UITextField()
        
        myVehicleMileageField.isEnabled = false
        myVehicleMileageField.borderStyle = .roundedRect
        let mileage = myVehicleMileage?.mileage ?? 0
        myVehicleMileageField.text = "\(String(mileage)) км"
        
        return myVehicleMileageField
    }()
    
    private lazy var clientLabel: UILabel = {
        let clientText = UILabel()
        clientText.text = "Клиент:"
        
        return clientText
    }()
    
    private lazy var clientTextField: UITextField = {
        let clientField = UITextField()
        
        clientField.isEnabled = false
        clientField.text = myCustomer?.name
        clientField.borderStyle = .roundedRect

        return clientField
    }()
    
    
    private lazy var serviceLabel: UILabel = {
        let serviceText = UILabel()
        serviceText.text = "Исполнитель:"
        
        return serviceText
    }()
    
    
    private lazy var serviceTextField: UITextField = {
        let serviceField = UITextField()
        
        serviceField.isEnabled = false
        serviceField.borderStyle = .roundedRect

        serviceField.text = myOrder?.masterFio
        
        return serviceField
    }()
    
    private lazy var tapWorkButton: UIButton = {
        let tapWork = UIButton()
        
        tapWork.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        tapWork.layer.cornerRadius = 7
        
        tapWork.setTitle("Работы", for: .normal)
        tapWork.setTitleColor(.white, for: .normal)
        
        return tapWork
    }()
    
    
    private lazy var tapZapButton: UIButton = {
        let tapZap = UIButton()
        
        tapZap.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
        tapZap.layer.cornerRadius = 7
        
        tapZap.setTitle("Товары", for: .normal)
        tapZap.setTitleColor(.white, for: .normal)
        
        return tapZap
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settupUi()
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        tapWorkButton.addTarget(self, action: #selector(workButtonTapped), for: .touchUpInside)
        
        tapZapButton.addTarget(self, action: #selector(zapButtonTapped), for: .touchUpInside)

    }
    
    func settupUi() {
        view.backgroundColor = .white
        
        documentStatusTextField.layer.borderWidth = 1
        documentStatusTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        documentStatusTextField.layer.cornerRadius = 10
        documentStatusTextField.borderStyle = .none
        
        paidStatusTextField.layer.borderWidth = 1
        paidStatusTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        paidStatusTextField.layer.cornerRadius = 10
        paidStatusTextField.borderStyle = .none
        
        remontStartTextField.layer.borderWidth = 1
        remontStartTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        remontStartTextField.layer.cornerRadius = 10
        remontStartTextField.borderStyle = .none
        
        carModelTextField.layer.borderWidth = 1
        carModelTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        carModelTextField.layer.cornerRadius = 10
        carModelTextField.borderStyle = .none
        
        regNumberTextField.layer.borderWidth = 1
        regNumberTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        regNumberTextField.layer.cornerRadius = 10
        regNumberTextField.borderStyle = .none
        
        vinNumberTextField.layer.borderWidth = 1
        vinNumberTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        vinNumberTextField.layer.cornerRadius = 10
        vinNumberTextField.borderStyle = .none
        
        myVehicleMileageTextField.layer.borderWidth = 1
        myVehicleMileageTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        myVehicleMileageTextField.layer.cornerRadius = 10
        myVehicleMileageTextField.borderStyle = .none
        
        clientTextField.layer.borderWidth = 1
        clientTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        clientTextField.layer.cornerRadius = 10
        clientTextField.borderStyle = .none
        
        serviceTextField.layer.borderWidth = 1
        serviceTextField.layer.borderColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0, alpha: 1)
        serviceTextField.layer.cornerRadius = 10
        serviceTextField.borderStyle = .none
        
        
        documentStatusTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        paidStatusTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        remontStartTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        carModelTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        regNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        vinNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        myVehicleMileageTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        clientTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        serviceTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    }
    
    @objc func closeButtonTapped() {
        print(#function)
        backToVc()
    }
    
    @objc func workButtonTapped() {
        
        print(#function)
        guard let orderId = myOrder?.id else { return }
        showWorkFromOrder(orderId: orderId)
    }
    
    @objc func zapButtonTapped() {
        
        print(#function)
        guard let orderId = myOrder?.id else { return }
        showZapFromOrder(orderId: orderId)
        
    }
    
    
    // MARK: - Routing
    func showWorkFromOrder(orderId: String) {
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceWorkViewController") as! ServiceWorkViewController
        popVC.orderId = orderId
        popVC.modalPresentationStyle = .fullScreen

        self.present(popVC, animated: true, completion: nil)
    }
    
    func showZapFromOrder(orderId: String) {
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ZapServiceViewController") as! ZapServiceViewController
        popVC.orderId = orderId
        popVC.modalPresentationStyle = .fullScreen

        self.present(popVC, animated: true, completion: nil)
    }
    
    func backToVc() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Constrains
    override func loadView() {
        super.loadView()
            
        view.addSubview(barView)
        barView.addSubview(closeButton)
        view.addSubview(scrollView)
        scrollView.addSubview(box)
        box.addSubview(documentStatusLabel)
        box.addSubview(documentStatusTextField)
        box.addSubview(paidStatusLabel)
        box.addSubview(paidStatusTextField)
        box.addSubview(remontStartLabel)
        box.addSubview(remontStartTextField)
        box.addSubview(carModelLabel)
        box.addSubview(carModelTextField)
        box.addSubview(regNumberLabel)
        box.addSubview(regNumberTextField)
        box.addSubview(vinNumberLabel)
        box.addSubview(vinNumberTextField)
        box.addSubview(myVehicleMileageLabel)
        box.addSubview(myVehicleMileageTextField)
        box.addSubview(clientLabel)
        box.addSubview(clientTextField)
        box.addSubview(serviceLabel)
        box.addSubview(serviceTextField)
        box.addSubview(tapWorkButton)
        box.addSubview(tapZapButton)
        
        
        barView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(Constants.barViewTop)
            $0.height.equalTo(Constants.barViewHeight)
        }
        
        
        closeButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.width.equalTo(90)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom).offset(8)
            $0.left.bottom.right.equalToSuperview()
        }
        
        box.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        documentStatusLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(box).offset(10)
        }
        
        documentStatusTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(documentStatusLabel.snp.bottom).offset(10)
        }
        
        paidStatusLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(documentStatusTextField.snp.bottom).offset(10)
        }
        
        paidStatusTextField.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(paidStatusLabel.snp.bottom).offset(10)
        }
        
        remontStartLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(paidStatusTextField.snp.bottom).offset(10)
        }
        
        remontStartTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(remontStartLabel.snp.bottom).offset(10)
        }
        
        carModelLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(remontStartTextField.snp.bottom).offset(10)
        }
        
        carModelTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(carModelLabel.snp.bottom).offset(10)
        }
        
        regNumberLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(carModelTextField.snp.bottom).offset(10)
        }
        
        regNumberTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(regNumberLabel.snp.bottom).offset(10)
        }
        
        vinNumberLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(regNumberTextField.snp.bottom).offset(10)
        }
        
        vinNumberTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(vinNumberLabel.snp.bottom).offset(10)
        }
        
        myVehicleMileageLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(vinNumberTextField.snp.bottom).offset(10)
        }
        
        myVehicleMileageTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(myVehicleMileageLabel.snp.bottom).offset(10)
        }
        
        clientLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(myVehicleMileageTextField.snp.bottom).offset(10)
        }
        
        clientTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(clientLabel.snp.bottom).offset(10)
        }
        
        serviceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(clientTextField.snp.bottom).offset(10)
        }
        
        serviceTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.top.equalTo(serviceLabel.snp.bottom).offset(10)
        }

        tapWorkButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.width.equalToSuperview().multipliedBy(0.42)
            $0.height.equalTo(40)
            $0.top.equalTo(serviceTextField.snp.bottom).offset(24)
            $0.bottom.equalTo(box).offset(-20)
        }

        tapZapButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.42)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.centerY.equalTo(tapWorkButton)
        }
        
    }
}

