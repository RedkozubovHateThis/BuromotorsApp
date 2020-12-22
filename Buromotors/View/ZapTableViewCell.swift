//
//  ZapTableViewCell.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 26.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class ZapTableViewCell: UITableViewCell {
    var serviceAddon: ServiceAddon?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setZapConfig(serviceAddon: ServiceAddon) {
        self.serviceAddon = serviceAddon
        nameLabel.text = serviceAddon.name
        priceLabel.text = "\(serviceAddon.count) x \(serviceAddon.cost)₽"
    }
    
}
