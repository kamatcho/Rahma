//
//  SearchCell.swift
//  Rahma
//
//  Created by MOHAMED on 3/15/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    

    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var SearchImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func ConfigureCell(SearchData : SearchModel){
        PhoneLabel.text = SearchData.mobile
        NameLabel.text = SearchData.name
        CountryLabel.text = SearchData.country
    }
    
}
