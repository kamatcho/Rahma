//
//  TimePickerVC.swift
//  Rahma
//
//  Created by MOHAMED on 3/12/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class TimePickerVC: UIViewController {
    var completion: ((_ date: Date) -> ())!

    @IBOutlet weak var TimePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TimePicker.backgroundColor = UIColor.groupTableViewBackground
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.hide))
        self.view.addGestureRecognizer(tapGest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func Set(_ sender: UIBarButtonItem) {
        self.completion(self.TimePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func hide(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)

    }

    

}
extension UIViewController {
    
    func ShowTimePickerController(completion: @escaping (_ date: Date) -> ()) {
        let TimePickers = UIStoryboard(name: "Start", bundle: nil).instantiateViewController(withIdentifier: "TimePickerViewController") as! TimePickerVC
        TimePickers.completion = completion
        TimePickers.modalPresentationStyle = .custom
        
        self.present(TimePickers, animated: true, completion: nil)
    }
}
