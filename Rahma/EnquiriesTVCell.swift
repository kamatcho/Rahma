//
//  EnquiriesTVCell.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/10/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class EnquiriesTVCell: UITableViewCell {
    
    static let identifier = "EnquiriesTVCell"
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    
}

extension UITableViewController {
    func registerEnquiriesTVCell() {
        self.tableView.register(UINib.init(nibName: EnquiriesTVCell.identifier, bundle: nil), forCellReuseIdentifier: EnquiriesTVCell.identifier)
    }
}
