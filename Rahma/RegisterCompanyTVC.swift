//
//  RegisterCompanyTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 2/21/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import MobileCoreServices

class RegisterCompanyTableViewController: UITableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: AMTextField!
    @IBOutlet weak var mobileTextField: AMTextField!
    @IBOutlet weak var mailTextField: AMTextField!
    @IBOutlet weak var passwordTextField: AMTextField!
    @IBOutlet weak var FacebookTxt: AMTextField!
    
    @IBOutlet weak var CountryKey: AMTextField!
    @IBOutlet weak var InstagramTxt: AMTextField!
    @IBOutlet weak var TwitterTxt: AMTextField!
    @IBOutlet weak var addressTextField: AMTextField!
    @IBOutlet weak var cityTextField: AMTextField!
    @IBOutlet weak var websiteTextField: AMTextField!
    
    @IBOutlet weak var countryButton: UIButton!
    
    var selectedCountry: APICountry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func country(_ sender: UIButton) {
        self.tableView.endEditing(true)
        let presenter = APICountryPresenter()
        presenter.showCountriesIn(vc: self, sender: sender) { (country) in
            self.selectedCountry = country
            sender.setTitle(country.name, for: .normal)
            self.CountryKey.text = country.Key
        }
    }
    
    var didAccept = false
    @IBAction func acceptTerms(_ sender: UIButton) {
        sender.setImage(self.didAccept ? #imageLiteral(resourceName: "Check") : #imageLiteral(resourceName: "UnCheck"), for: .normal)
        self.didAccept = !self.didAccept
    }
    
    @IBAction func register(_ sender: UIButton) {
        guard self.selectedCountry != nil else {
            return
        }
        
        guard !self.didAccept else {
            self.showAlert(title: "يجب عليك الموافقة علي شروط التطبيق أولا", message: "")
            return
        }
        
        sender.showActivityIndicator()
        APIHelper.registerCompany(name: self.nameTextField.text!, mobile: self.mobileTextField.text!, address: self.addressTextField.text!, city: self.cityTextField.text!, country: self.countryButton.titleLabel!.text!, website: self.websiteTextField.text!, mail: self.mailTextField.text!, password: self.passwordTextField.text!, phonecode : self.CountryKey.text! ,image: self.userImageView.image) { (status, user) in
            if status.isSuccess {
                user?.saveUserToDefaults()
                self.segueToMainTabBar()
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "إفتح الكاميرا", style: UIAlertActionStyle.default, handler: { (success) -> Void in
            self.OpenImagePickerWithType(UIImagePickerControllerSourceType.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "إختر من الصور", style: UIAlertActionStyle.default, handler: { (success) -> Void in
            self.OpenImagePickerWithType(UIImagePickerControllerSourceType.photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler:nil))
        
        alert.popoverPresentationController?.sourceRect = (sender.bounds)
        alert.popoverPresentationController?.sourceView = sender
        self.present(alert, animated: true, completion: nil)
    }
    
    func OpenImagePickerWithType(_ Type:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = Type
        picker.mediaTypes = [kUTTypeImage as String]
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}

extension RegisterCompanyTableViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.dismiss(animated: true, completion: {
            self.userImageView.image = image
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
