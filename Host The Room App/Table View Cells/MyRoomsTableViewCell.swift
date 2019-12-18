//
//  MyRoomsTableViewCell.swift
//  Host The Room App
//
//  Created by Sashank Vempati on 9/12/19.
//  Copyright © 2019 Sashank Vempati. All rights reserved.
//

import UIKit

class MyRoomsTableViewCell: UITableViewCell {

    @IBOutlet weak var MyRoomImageView: UIImageView!
    @IBOutlet weak var MyRoomDescription: UILabel!
    @IBOutlet weak var MyRoomRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
