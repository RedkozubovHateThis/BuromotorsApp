//
//  WorksViewCell.swift
//  Buromotors
//
//  Created by Ахмед Фокичев on 25.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class WorksViewCell: UITableViewCell {

    var serviceWork: ServiceWork?
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConfig(serviceWork: ServiceWork) {
        self.serviceWork = serviceWork
        labelData.text = serviceWork.name
        priceLabel.text = "\(serviceWork.count) x \(serviceWork.price)₽"
       // labelNumber.text = String(serviceWork.number)
    }
}
