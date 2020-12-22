//
//  DocumentTableViewCell.swift
//  Buromotors
//
//  Created by Anton Redkozubov on 07.10.2020.
//  Copyright © 2020 Anton Redkozubov. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelinfo: UILabel!
    @IBOutlet weak var autoServiceLabel: UILabel!
    @IBOutlet weak var coastLable: UILabel!
    @IBOutlet var gosNumberLabel: UILabel!
    @IBOutlet weak var paidStatusLabel: UILabel!
    
    var doc: ServiceDocument?
    var vehicle: Vehicle?
    var vehicleMileage: VehicleMileage?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConfig(doc: ServiceDocument, vehicle: Vehicle?) {
        self.doc = doc
        self.vehicle = vehicle
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd.MM.yyyy hh:mm"
        
        if let adEntity = doc.adEntity {
            self.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.4352941176, blue: 0.9764705882, alpha: 1)
            labelinfo.textColor = .white
            coastLable.textColor = .white
            autoServiceLabel.textColor = .white
            gosNumberLabel.textColor = .white
            labelinfo.text = adEntity.description
            coastLable.text = adEntity.name
            autoServiceLabel.text = adEntity.phone
            if adEntity.email.isEmpty {
                gosNumberLabel.isHidden = true
            } else {
                gosNumberLabel.text = adEntity.email
            }
        } else {
            self.backgroundColor = .white
            labelinfo.textColor = .black
            coastLable.textColor = .black
            autoServiceLabel.textColor = .black
            gosNumberLabel.textColor = .black
            labelinfo.text = formatter3.string(from: doc.startDate)
            //        paidStatusLabel.text = doc.paidStatus.rawValue
            autoServiceLabel.text = vehicle?.modelName
            gosNumberLabel.text = vehicle?.regNumber
            coastLable.text = "\(String(doc.cost))₽"
        }
        
    }
    
    
}
