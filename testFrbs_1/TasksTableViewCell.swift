//
//  TasksTableViewCell.swift
//  testFrbs_1
//
//  Created by ac1ra on 12/11/2018.
//  Copyright © 2018 0I00II. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var completedSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
