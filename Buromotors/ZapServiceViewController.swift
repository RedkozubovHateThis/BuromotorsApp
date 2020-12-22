//
//  ZapServiceViewController.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 19.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class ZapServiceViewController: UIViewController {

    let workOrderService = WorkOrderService()
    var orderId: String?
    var serviceAddons = [ServiceAddon]()
    
    @IBOutlet weak var viewLabel: UITableView!
    @IBOutlet var exitLabel: UIButton!
    @IBOutlet var summaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let token = TokenService.shared.access_token
        
        viewLabel.register(UINib(nibName: "ZapTableViewCell", bundle: nil), forCellReuseIdentifier: "ZapTableViewCell")
        viewLabel.delegate = self
        viewLabel.dataSource = self
        
        print("orderId>", orderId)
        if let orderId = orderId {
            workOrderService.loadMyAddonInOrder(myOrderId: orderId, token: token) { [weak self] (list, state, error)  in
                
                print("loadMyAddonInOrder>list>", list.count)
                self?.serviceAddons = list
                
                var summa = 0
                for x in list {
                    summa += x.count * Int(x.cost)
                }
                self?.summaLabel.text = String(summa) + "₽"
                
                self?.viewLabel.reloadData()
            }
        }
        
    }
    
    @IBAction func tapExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
    
extension ZapServiceViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            serviceAddons.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZapTableViewCell", for: indexPath) as! ZapTableViewCell
            
            let serviceAddon = serviceAddons[indexPath.row]
            
            cell.setZapConfig(serviceAddon: serviceAddon)
            return cell
        }
    
    }

