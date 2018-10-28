//
//  HospitalTVCell.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/8/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class HospitalTVCell: UITableViewCell {
    
    static let identifier = "HospitalTVCell"
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var hospitalImageView: UIImageView!
    
    var hospital: APIHospital!
    
    func setupCell(_ hospital: APIHospital) {
        self.hospital = hospital
        self.nameTextLabel.text = hospital.name
        self.addressTextLabel.text = hospital.address
        
        if let url = URL(string: hospital.image) {
            self.hospitalImageView.image = nil
            self.hospitalImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.hospitalImageView.hnk_setImageFromURL(url, failure: { error in
                self.hospitalImageView.hideActivityIndicator()
            }, success: { image in
                self.hospitalImageView.image = image
                self.hospitalImageView.hideActivityIndicator()
            })
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.segueToHospitalDetailsTVC()
        }
    }
    
    func segueToHospitalDetailsTVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetailTableViewController") as! HospitalDetailTableViewController
        destinationVC.hospital = self.hospital
        UIApplication.shared.keyWindow!.visibleViewController!.show(destinationVC, sender: nil)
    }
    
}

extension UITableViewController {
    func registerHospitalTVCell() {
        self.tableView.register(UINib.init(nibName: HospitalTVCell.identifier, bundle: nil), forCellReuseIdentifier: HospitalTVCell.identifier)
    }
}
