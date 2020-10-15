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
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var autoServiceLabel: UILabel!
    @IBOutlet weak var coastLable: UILabel!
    
    var doc: ServiceDocument?
    var vehicle: Vehicle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConfig(doc: ServiceDocument) {
        self.doc = doc
        labelinfo.text = doc.startDate
        autoServiceLabel.text = doc.masterFio
        coastLable.text = String(doc.cost)
    }
    
}
