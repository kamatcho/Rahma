//
//  RegisterTableViewController.swift
//  Ekeif
//
//  Created by Amr Mohamed on 9/13/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit
import MobileCoreServices

class RegisterPatientTableViewController: UITableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: AMTextField!
    @IBOutlet weak var mobileTextField: AMTextField!
    @IBOutlet weak var cityTextField: AMTextField!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var mailTextField: AMTextField!
    @IBOutlet weak var passwordTextField: AMTextField!
    
    @IBOutlet weak var CountryKey: AMTextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var birthdateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var selectedGender: APIGender?
    @IBAction func gender(_ sender: UIButton) {
        APIGender.showAlertIn(vc: self) { gender in
            self.selectedGender = gender
            sender.setTitle(gender.title, for: .normal)
        }
    }
    
    var birthdate: Date?
    @IBAction func birthdate(_ sender: UIButton) {
        self.showDatesPickerViewController { date in
            self.birthdate = date
            sender.setTitle(date.readableDate, for: .normal)
        }
    }
    
    var selectedCountry: APICountry?
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
        guard self.selectedCountry != nil, self.birthdate != nil else {
            return
        }
        
        guard !self.didAccept else {
            self.showAlert(title: "يجب عليك الموافقة علي` شروط التطبيق أولا", message: "")
            return
        }
        
        sender.showActivityIndicator()
        APIHelper.registerPatient(name: self.nameTextField.text!, mobile: self.mobileTextField.text!, age: String(self.birthdate!.timeIntervalSince1970), city: self.cityTextField.text!, gender: self.selectedGender!.value, country: self.countryButton.titleLabel!.text!, mail: self.mailTextField.text!, password: self.passwordTextField.text!,phonecode: self.CountryKey.text! ,image: self.userImageView.image) { (status) in
            if status.isSuccess {
                self.segueToMainTabBar()
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.actionSheet)
        
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


extension RegisterPatientTableViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.dismiss(animated: true, completion: {
            self.userImageView.image = image
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
