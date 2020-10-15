//
//  OrdersListViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 25.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class OrdersListViewController: UIViewController {

    @IBOutlet weak var titaleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    var myOrder: ServiceDocument?
//    var myVehicle: Vehicle?
    var orderService: OrderService?
    var docs = [ServiceDocument]()
    var vehicles = [Vehicle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderService = OrderService.shared
        
        let token = TokenService.shared.access_token
        
        tableView.register(UINib(nibName: "DocumentTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        orderService?.loadMyOrders(token: token, completion: { (docs, state, error) in
            self.docs = docs
//            self.vehicles = self.vehicles
            self.tableView.reloadData()
        })
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapButtonMyProfile(_ sender: Any) {
        showMyProfile()
    }
    
    func showMyProfile() {
        print(#function)
        performSegue(withIdentifier: "showMyProfile", sender: nil)
    }
    
    
    
    func showDetailOrder(serviceDocument: ServiceDocument){
        print(#function)
        
        print(serviceDocument.number)
        print(serviceDocument.startDate)
        
        
//        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
//        popVC.myOrder = serviceDocument
//        popVC.modalPresentationStyle = .fullScreen
//
//        self.present(popVC, animated: true, completion: nil)
    }
    
}

extension OrdersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // withIdentifier: "DocumentTableViewCell для XIB
        // as! DocumentTableViewCell для Swift файла
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCell", for: indexPath) as! DocumentTableViewCell
        let doc = docs[indexPath.row]
//        let vehicle = vehicles[indexPath.row]
        
        cell.setConfig(doc: doc)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let doc = docs[indexPath.row]
        showDetailOrder(serviceDocument: doc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if view.bounds.height > 800 {
            
        }
        
        return 120
        
    }
    
}
