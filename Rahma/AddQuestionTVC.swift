//
//  AddQuestionTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/15/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class AddQuestionTableViewController: UITableViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var questionTextViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.questionTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func done(_ sender: UIButton) {
        sender.showActivityIndicator()
        APIHelper.addEnquiry(title: self.questionTextView.text) { (status) in
            if status.isSuccess {
                self.showStatusBarNotification("Your Question added Successfully")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddQuestionTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.tableView.beginUpdates()
        self.changeTextViewHeight()
        self.tableView.endUpdates()
    }
    
    func changeTextViewHeight() {
        let height = self.questionTextView.contentSize.height + 10
        if height > 85 {
            self.questionTextViewHeight.constant = height
        }
        self.questionTextView.setContentOffset(CGPoint.zero, animated: true)
    }
}
