//
//  CustomersTableViewCell.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/12/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class CustomersTableViewCell: UITableViewCell {

    @IBOutlet weak var CustomerImageView: UIImageView!
    @IBOutlet weak var CustomerNameLabel: UILabel!
    @IBOutlet weak var TotalHoursLabel: UILabel!
    @IBOutlet weak var DateTimeBookedLabel: UILabel!
    @IBOutlet weak var TotalAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
