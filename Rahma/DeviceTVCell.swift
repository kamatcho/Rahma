//
//  DeviceTVCell.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/8/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import NYTPhotoViewer

class DeviceTVCell: UITableViewCell {
    
    static let identifier = "DeviceTVCell"
    
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var devicePriceTextLabel: UILabel!
    @IBOutlet weak var deviceDescriptionTextLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    
    var device: APIDevice!
    
    func setupCell(_ device: APIDevice) {
        self.device = device
        self.userNameTextLabel.text = device.user.name
        
        if let url = URL.init(string: device.user.image) {
            self.userImageView.image = nil
            self.userImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.userImageView.hnk_setImageFromURL(url, failure: { error in
                self.userImageView.hideActivityIndicator()
            }, success: { image in
                self.userImageView.image = image
                self.userImageView.hideActivityIndicator()
            })
        }
        
        self.devicePriceTextLabel.text = device.price == "Free" ? "مجاني" : device.price
        self.deviceDescriptionTextLabel.text = device.description
        
        if let url = URL(string: device.image) {
            self.deviceImageView.image = nil
            self.deviceImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.deviceImageView.hnk_setImageFromURL(url, failure: { error in
                self.deviceImageView.hideActivityIndicator()
            }, success: { image in
                self.deviceImageView.image = image
                self.deviceImageView.hideActivityIndicator()
            })
        }
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.showImageViewer))
        self.deviceImageView.addGestureRecognizer(tapGest)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.showDeviceDetails()
        }
    }
    
    func showImageViewer() {
        guard self.deviceImageView.image != nil else {
            return
        }
        
        let photo = PopupPhoto()
        photo.image = self.deviceImageView.image
        let photosVC = NYTPhotosViewController(photos: [photo])
        UIApplication.shared.keyWindow!.visibleViewController!.present(photosVC, animated: true, completion: nil)
    }
    
}

extension UITableViewController {
    func registerDeviceTVCell() {
        self.tableView.register(UINib.init(nibName: DeviceTVCell.identifier, bundle: nil), forCellReuseIdentifier: DeviceTVCell.identifier)
    }
}


extension DeviceTVCell: UIPopoverPresentationControllerDelegate {
    
    func showDeviceDetails() {
        let vc = UIApplication.shared.keyWindow!.visibleViewController!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countriesNav = storyboard.instantiateViewController(withIdentifier: "DeviceDetailsTableViewControllerNavigation") as! UINavigationController
        let deviceDetailsTVC = countriesNav.viewControllers.first! as! DeviceDetailsTableViewController
        deviceDetailsTVC.device = self.device
        
        countriesNav.modalPresentationStyle = .popover
        countriesNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 280)
        
        let popover = countriesNav.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = self
        popover.sourceRect = CGRect(x: self.bounds.midX, y: self.bounds.midY , width: 0, height: 0)
        popover.permittedArrowDirections = [.up, .down]
        
        vc.present(countriesNav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

class PopupPhoto: NSObject, NYTPhoto {
    
    var image: UIImage?
    
    var placeholderImage: UIImage?
    var imageData: Data?
    
    var attributedCaptionTitle: NSAttributedString?
    var attributedCaptionCredit: NSAttributedString?
    var attributedCaptionSummary: NSAttributedString?
}
