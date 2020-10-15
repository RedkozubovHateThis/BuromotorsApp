//
//  OrderDetailsViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 08.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {


//    Статусы (В заказ наряде)
//    Статус оплаты (ServiceDocument)
//    Дата начала ремонта (ServiceDocument) есть
//    Марка модель (VEHICLE)
//    Вин (VEHICLE)
//    Номер авто (VEHICLE)
//    Пробег (VEHICLE_MILEAGE)
//    Клиент (полное) (ServiceDocument)есть
//    Исполнитель (полное) (ServiceDocument)есть
//    Сумма по зн (ServiceDocument)есть
//    Назвение работы и стоимость (ServiceWork)
//    Название товара и стоимость товара и кол-во (ServiceAddon)
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var paidStatusLabel: UILabel!
    @IBOutlet var remontStartDate: UILabel!
    @IBOutlet var carModelLabel: UILabel!
    @IBOutlet var regNumberLabel: UILabel!
    @IBOutlet var vinNumberLabel: UILabel!
    @IBOutlet var millageNumber: UILabel!
    @IBOutlet var clientLabel: UILabel!
    @IBOutlet var workerLabel: UILabel!
    
    
    var myOrder: ServiceDocument?
    var myVehicle: Vehicle?
    var orderService: OrderService?
    //    var vehicles = [Vehicle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let order = myOrder {
            
            print(order.number)
            print(order.startDate)
            print(order.masterFio)
            
            
        }
        
        
//        let token = TokenService.shared.access_token
        
//        orderService?.loadMyOrders(token: token, completion: { (docs, state, error) in
//            self.docs = docs
////            self.tableView.reloadData()
//        })
        
        
//        statusLabel.text =
//        paidStatusLabel.text =
   //     remontStartDate.text = myOrder?.startDate
//        carModelLabel.text =
        regNumberLabel.text = myVehicle?.regNumber
//        vinNumberLabel.text =
//        millageNumber.text =
//        clientLabel.text =
     //   workerLabel.text = myOrder?.masterFio
    }
    

    @IBAction func tapBackButton(_ sender: Any) {
        backToVc()
    }
    
    func backToVc() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }

}


