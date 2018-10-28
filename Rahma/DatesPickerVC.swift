//
//  DatesTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 2/21/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class DatesPickerViewController: UIViewController {
    
    var completion: ((_ date: Date) -> ())!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.backgroundColor = UIColor.groupTableViewBackground
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.hide))
        self.view.addGestureRecognizer(tapGest)
//        tapGest.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hide() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pick() {
        self.completion(self.datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func showDatesPickerViewController(completion: @escaping (_ date: Date) -> ()) {
        let datesPicker = UIStoryboard(name: "Start", bundle: nil).instantiateViewController(withIdentifier: "DatesPickerViewController") as! DatesPickerViewController
        datesPicker.completion = completion
        datesPicker.modalPresentationStyle = .custom
        
        self.present(datesPicker, animated: true, completion: nil)
    }
    
    
    
}
