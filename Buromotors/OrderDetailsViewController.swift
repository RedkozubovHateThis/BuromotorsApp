//
//  OrderDetailsViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 08.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet var remontStartDate: UILabel!
    @IBOutlet var statusTextField: UITextField!
    @IBOutlet var paidStatusTextField: UITextField!
    @IBOutlet var remontStartTextField: UITextField!
    @IBOutlet var carModelTextField: UITextField!
    @IBOutlet var regNumberTextField: UITextField!
    @IBOutlet var vinNumberTextField: UITextField!
    @IBOutlet var milageTextField: UITextField!
    @IBOutlet var clientTextFiled: UITextField!
    @IBOutlet var serviceTextField: UITextField!
    
    var myOrder: ServiceDocument?
    var myVehicle: Vehicle?
    var myVehicleMileage: VehicleMileage?
    var myCustomer: Customer?
    var orderService: OrderService?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusTextField.isEnabled = false
        paidStatusTextField.isEnabled = false
        remontStartDate.isEnabled = false
        carModelTextField.isEnabled = false
        regNumberTextField.isEnabled = false
        vinNumberTextField.isEnabled = false
        milageTextField.isEnabled = false
        clientTextFiled.isEnabled = false
        serviceTextField.isEnabled = false
// Mark - PaidStatus 
        if let paidStatus = myOrder?.paidStatus {
            if paidStatus == .paid {
                paidStatusTextField.text = "Оплачен"
            }
            if paidStatus == .notPaid {
                paidStatusTextField.text = "Не оплачен"
            }
        }
        
// Mark - DocumentStatus
        
        if let documentStatus = myOrder?.status {
            if documentStatus == .complited {
                statusTextField.text = "Оформлен"
            }
            if documentStatus == .created {
                statusTextField.text = "Заявка"
            }
            if documentStatus == .inWork {
                statusTextField.text = "В работе"
            }
        }
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd.MM.yyyy hh:mm"
        
        remontStartTextField.text = formatter3.string(from: myOrder?.startDate ?? Date())
        carModelTextField.text = myVehicle?.modelName
        regNumberTextField.text = myVehicle?.regNumber
        vinNumberTextField.text = myVehicle?.vinNumber
        let mileage = myVehicleMileage?.mileage ?? 0
        milageTextField.text = "\(String(mileage)) км"
        clientTextFiled.text = myCustomer?.name
        serviceTextField.text = myOrder?.masterFio
        
        if let order = myOrder {
            
            print(order.number)
            print(order.startDate)
            print(order.masterFio)
            
            
        }
        
        print("myVehicle?.modelName>",myVehicle?.modelName)
        print("myVehicleMileage?.mileage>", myVehicleMileage?.mileage)
    }
    
    @IBAction func tapWorkButton(_ sender: Any) {
        print(#function)
        guard let orderId = myOrder?.id else { return }
        showWorsFromOrder(orderId: orderId)
    }
    
    @IBAction func tapZapButton(_ sender: Any) {
        print(#function)
        guard let orderId = myOrder?.id else { return }
        showZapFromOrder(orderId: orderId)
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        print(#function)
        backToVc()
    }
    
    func backToVc() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
  
    
    
    
    // Routing
    func showWorsFromOrder(orderId: String) {
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
}


