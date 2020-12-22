//
//  ServiceWorkViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 19.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class ServiceWorkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var exitLabel: UIButton!
    
    let workOrderService = WorkOrderService()
    var orderId: String?
    var serviceWorks = [ServiceWork]()
    
    @IBOutlet weak var labelItogo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let token = TokenService.shared.access_token
        
        tableView.register(UINib(nibName: "WorksViewCell", bundle: nil), forCellReuseIdentifier: "WorksViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        if let orderId = orderId {
            workOrderService.loadMyWorkInOrder(orderId: orderId, token: token) { [weak self] (list, state, error)  in
                self?.serviceWorks = list
                
                var summa = 0
                for obj in list {
                    summa += obj.count * Int(obj.price)
                }
                self?.labelItogo.text = String(summa) + "₽"
                
                self?.tableView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func tapExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ServiceWorkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        serviceWorks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorksViewCell", for: indexPath) as! WorksViewCell
        
        let serviceWork = serviceWorks[indexPath.row]
        
        cell.setConfig(serviceWork: serviceWork)
       // cell.textLabel?.text = "name=" + serviceWork.name + " price=" + String(serviceWork.price) + "count>" + String(serviceWork.count)

        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // withIdentifier: "DocumentTableViewCell для XIB
//        // as! DocumentTableViewCell для Swift файла
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WorksTableViewCell", for: indexPath) as! WorksTableViewCell
//        let serviceWork = serviceWorks[indexPath.row]
//
//        if let workId = serviceWork.id {
//            cell.setConfigWork(serviceWork: workId)
//        } else {
//            cell.setConfigWork(serviceWork: nil)
//        }
//
//        return cell
//    }
    
}
