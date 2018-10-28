//
//  UserTVCell.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/14/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class UserTVCell: UITableViewCell {
    
    static let identifier = "UserTVCell"
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
