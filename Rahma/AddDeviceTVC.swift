//
//  AddDeviceTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/13/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class AddDeviceTableViewController: UITableViewController {
    
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var priceTableViewCell: UITableViewCell!
    @IBOutlet weak var priceTextField: AMTextField!
    @IBOutlet weak var descriptionTextField: AMTextField!
    
    var price: String {
        let text = self.priceTextField.text!
        return text == "" ? "Free" : text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.priceTableViewCell.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if cell.isHidden {
            return 0
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @IBAction func segmentedControlValueChanged() {
        self.tableView.beginUpdates()
        self.priceTableViewCell.isHidden = self.segmentedControl.selectedSegmentIndex == 0
        self.tableView.endUpdates()
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "إفتح الكاميرا", style: UIAlertActionStyle.default, handler: { (success) -> Void in
            self.OpenImagePickerWithType(UIImagePickerControllerSourceType.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "إختر من الصور", style: UIAlertActionStyle.default, handler: { (success) -> Void in
            self.OpenImagePickerWithType(UIImagePickerControllerSourceType.photoLibrary)
        }))
        
        if self.deviceImageView.image != nil {
            alert.addAction(UIAlertAction(title: "مسح الصورة الحالية", style: UIAlertActionStyle.default, handler: { (success) -> Void in
                self.deviceImageView.image = nil
            }))
        }
        
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
    
    @IBAction func done(_ sender: UIButton) {
        sender.showActivityIndicator()
        APIHelper.addDevice(id: APIUser.main.id, kind: APIUser.main.kind, type: self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex)!, price: self.price, description: self.descriptionTextField.text!, image: self.deviceImageView.image, completion: { (status) in
            if status.isSuccess {
                self.dismiss(animated: true) {
                    self.showStatusBarNotification("تم إضافة الجهاز بنجاح")
                }
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }) { (progress) in
            print(progress)
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddDeviceTableViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.dismiss(animated: true, completion: {
            self.deviceImageView.image = image
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
