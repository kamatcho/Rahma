//
//  ExperienceTVCell.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/12/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class ExperienceTVCell: UITableViewCell {
    
    static let identifier = "ExperienceTVCell"
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var doctorTextLabel: UILabel!
    @IBOutlet weak var hospitalTextLabel: UILabel!
    @IBOutlet weak var countryTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UITextView!
    @IBOutlet weak var dateTextLabel: UILabel!
    
    func setupCell(_ experience: APIExperience) {
        self.nameTextLabel.text = experience.user.name
        self.doctorTextLabel.text = experience.doctor
        self.hospitalTextLabel.text = experience.hospital
        self.countryTextLabel.text = experience.country
        self.bodyTextLabel.text = experience.body
        self.dateTextLabel.text = experience.date
        
        if let url = URL(string: experience.user.image) {
            self.userImageView.image = nil
            self.userImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.userImageView.hnk_setImageFromURL(url, failure: { error in
                self.userImageView.hideActivityIndicator()
            }, success: { image in
                self.userImageView.image = image
                self.userImageView.hideActivityIndicator()
            })
        }
    }
    
}

extension UITableViewController {
    func registerExperienceTVCell() {
        self.tableView.register(UINib.init(nibName: ExperienceTVCell.identifier, bundle: nil), forCellReuseIdentifier: ExperienceTVCell.identifier)
    }
}
