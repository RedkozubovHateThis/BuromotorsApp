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
    var myVehicle: Vehicle?
    var orderService: OrderService?
    var docs = [ServiceDocument]()
    var vehicles = [Vehicle]()
    var activityIndicatorView = UIActivityIndicatorView()
    var docFilter = DocFilter(state: "", paidState: "", organization: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderService = OrderService.shared
        
        tableView.register(UINib(nibName: "DocumentTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        loadOrders(filter: nil)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = true
        
    }

    @IBAction func tapButtonMyProfile(_ sender: Any) {
        showMyProfile()
    }
    
    @IBAction func tapButtomFilter(_ sender: Any) {
        showFilter()
    }
    
    func showMyProfile() {
        print(#function)
        performSegue(withIdentifier: "showMyProfile", sender: nil)
    }
    
    func showFilter() {
        print(#function)
        performSegue(withIdentifier: "showFilter", sender: nil)
    }
    
    func showDetailOrder(serviceDocument: ServiceDocument){
        guard let vehicleId = serviceDocument.serviceRelationships?.vehicle.data.id  else {return}
        guard let vehicleMileageId = serviceDocument.serviceRelationships?.vehicleMileage.data.id  else {return}
        guard let customerId = serviceDocument.serviceRelationships?.customer.data.id  else {return}
//        guard let orderServiceId = serviceDocument.serviceRelationships?.client.id  else {return}
        guard let orderService = orderService  else {return}
        
        print("vehicleId>", vehicleId)
        print("vehicleMileageId>", vehicleMileageId)
        
        var vehicle: Vehicle?
        for v in orderService.vehicles {
            if v.id == vehicleId {
                vehicle = v
            }
        }
        
        var vehicleMileage: VehicleMileage?
        for v in orderService.vehicleMileages {
            if v.id == vehicleMileageId {
                vehicleMileage = v
            }
        }

        var customer: Customer?
        print("customerId>", customerId)
        for v in orderService.customers {
            print("v>", v.id)
            if v.id == customerId {
                customer = v
            }
        }

            
        if let myVehicle = vehicle {
            
//            let regUserViewController = RegUserViewController()
//            regUserViewController.modalPresentationStyle = .fullScreen
//            self.present(regUserViewController, animated: true, completion: nil)
            
            let popVC = OrdersDetailsViewController()
            popVC.myOrder = serviceDocument
            popVC.myVehicle = myVehicle
            popVC.myVehicleMileage = vehicleMileage
            popVC.myCustomer = customer
            
            popVC.modalPresentationStyle = .fullScreen

            self.present(popVC, animated: true, completion: nil)
        }
     
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
        
        if let vehicleId = doc.serviceRelationships?.vehicle.data.id, let vehicle = orderService?.getVehicle(id: vehicleId) {
            cell.setConfig(doc: doc, vehicle: vehicle)
        } else {
            cell.setConfig(doc: doc, vehicle: nil)
        }
        
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
        
        return 90

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height && activityIndicatorView.isHidden {
            print("scrollViewDidScroll>")
            loadOrders(filter: nil)
        }
    }
    
    func loadOrders(filter: DocFilter?) {
        activityIndicatorView.isHidden = false
        let token = TokenService.shared.access_token
        orderService?.loadMyOrders(token: token, filter: filter, completion: { [self] (docs, state, error) in
            self.docs = docs
            if let adEntity = AdvertisingService.shared.myAdvertising {
                if self.docs.isEmpty {
                    self.docs.append(ServiceDocument(adEntity: adEntity))
                } else {
                    self.docs.insert(ServiceDocument(adEntity: adEntity), at: 1)
                }
                
            }
            self.tableView.reloadData()
            activityIndicatorView.isHidden = true
        })
    }
    
    
    
}
