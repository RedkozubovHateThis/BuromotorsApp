//
//  UIViewConctroller+extension.swift
//  Buromotors
//
//  Created by Ахмед Фокичев on 25.09.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showMassege(title:String, massage: String) {
        let alertController = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
