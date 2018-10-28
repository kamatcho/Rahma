//
//  ProfileTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/10/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import MobileCoreServices

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var statusTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.statusTextLabel.text = APIUser.main.status
        self.navigationItem.title = APIUser.main.name
        if let url = URL(string: APIUser.main.image) {
            self.userImageView.image = nil
            self.addImageButton.setTitleColor(.clear, for: .normal)
            self.userImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.userImageView.hnk_setImageFromURL(url, failure: { error in
                self.userImageView.hideActivityIndicator()
            }, success: { image in
                self.userImageView.image = image
                self.userImageView.hideActivityIndicator()
                self.addImageButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 0, section: self.tableView.numberOfSections - 1) {
            self.logout()
        }
    }
    
    func logout() {
        let alert = UIAlertController(title: "هل أنت متأكد من أنك تريد تسجيل الخروج", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "تسجيل الخروج", style: .destructive, handler: {
            action in
            APIUser.removeUserFromDefaults()
            self.segueToLoginTVC()
        }))
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
    
    func updateUserProfile() {
        self.userImageView.showActivityIndicator(shouldAdjustYAxis: false)
        APIHelper.updateProfileImage(id: APIUser.main.id, kind: APIUser.main.kind, image: self.userImageView.image) { (status, user) in
            if status.isSuccess {
                self.showStatusBarNotification("تم تحديث الصورة الشخصية")
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            self.userImageView.hideActivityIndicator()
        }
    }
}

extension ProfileTableViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.dismiss(animated: true, completion: {
            self.userImageView.image = image
            self.updateUserProfile()
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
