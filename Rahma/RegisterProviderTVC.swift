//
//  RegisterTableViewController.swift
//  Ekeif
//
//  Created by Amr Mohamed on 9/13/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit
import MobileCoreServices

class RegisterProviderTableViewController: UITableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: AMTextField!
    @IBOutlet weak var mobileTextField: AMTextField!
    @IBOutlet weak var civilRegisteryTextField: AMTextField!
    @IBOutlet weak var carTypeTextField: AMTextField!
    @IBOutlet weak var mailTextField: AMTextField!
    @IBOutlet weak var passwordTextField: AMTextField!
    
    @IBOutlet weak var CountryKey: AMTextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var serviceTypeButton: UIButton!
    @IBOutlet weak var medicationTypeButton: UIButton!
    @IBOutlet weak var Currency: UIButton!
    
    @IBOutlet weak var carTypeTableViewCell: UITableViewCell!
    @IBOutlet weak var medicationTypeTableViewCell: UITableViewCell!
    
    // therapist cells
    @IBOutlet weak var PhysiotherapistCell: UITableViewCell!
    @IBOutlet weak var PsychologistCell: UITableViewCell!
    @IBOutlet weak var OccupationalCell: UITableViewCell!
    @IBOutlet weak var SocialCell: UITableViewCell!
    @IBOutlet weak var recreationalCell: UITableViewCell!
    @IBOutlet weak var CounselingCell: UITableViewCell!
    @IBOutlet weak var EducationCell: UITableViewCell!
    @IBOutlet weak var SpeachCel: UITableViewCell!
    
    @IBOutlet weak var TimeValueTxt: AMTextField!
    @IBOutlet weak var StudyingCell: UITableViewCell!
    @IBOutlet weak var CarButton: UIButton!
    //End Of Cells
    
    //Therapist Labels
    @IBOutlet weak var PhysiotherapistText: UILabel!
    @IBOutlet weak var PsychologistText: UILabel!
    @IBOutlet weak var OccupationalText: UILabel!
    @IBOutlet weak var SocialText: UILabel!
    @IBOutlet weak var SpeechText: UILabel!
    @IBOutlet weak var recreationalText: UILabel!
    @IBOutlet weak var CounselingText: UILabel!
    @IBOutlet weak var educationText: UILabel!
    // End Of Labels
    
    // المرافق
    
    @IBOutlet weak var InHospitalCell: UITableViewCell!
    @IBOutlet weak var ExamsCell: UITableViewCell!
    @IBOutlet weak var InHomeCell: UITableViewCell!
    @IBOutlet weak var DailyCell: UITableViewCell!
    
    @IBOutlet weak var TimeCell: UITableViewCell!
    // End of Cells
    
    // Driver Cells
    @IBOutlet weak var HaveAcarCell: UITableViewCell!
    
    @IBOutlet weak var CarCell: UITableViewCell!
    
    // labels 
    @IBOutlet weak var inHospitalText: UILabel!
    @IBOutlet weak var ExamsLabel: UILabel!
    @IBOutlet weak var InHomeText: UILabel!
    @IBOutlet weak var DailyText: UILabel!
    
    @IBOutlet weak var StudyText: UILabel!
    @IBOutlet weak var CityText: AMTextField!
    
    var selectedCountry: APICountry?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.beginUpdates()
        self.carTypeTableViewCell.isHidden = true
        self.medicationTypeTableViewCell.isHidden = true
        self.PhysiotherapistCell.isHidden = true
        self.PsychologistCell.isHidden = true
        self.OccupationalCell.isHidden = true
        self.SocialCell.isHidden = true
        self.SpeachCel.isHidden = true
        self.recreationalCell.isHidden = true
        self.CounselingCell.isHidden = true
        self.EducationCell.isHidden = true
        self.InHospitalCell.isHidden = true
        self.ExamsCell.isHidden = true
        self.InHomeCell.isHidden = true
        self.DailyCell.isHidden = true
        self.StudyingCell.isHidden = true
        self.HaveAcarCell.isHidden = true
        self.CarCell.isHidden = true
        self.TimeCell.isHidden = true
        self.tableView.endUpdates()
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
    
    @IBAction func gender(_ sender: UIButton) {
        APIGender.showAlertIn(vc: self) { gender in
            sender.setTitle(gender.title, for: .normal)
        }
    }
    
    @IBAction func country(_ sender: UIButton) {
        self.tableView.endEditing(true)
        let presenter = APICountryPresenter()
        presenter.showCountriesIn(vc: self, sender: sender) { (country) in
            self.selectedCountry = country
            sender.setTitle(country.name, for: .normal)
            self.CountryKey.text = country.Key
            self.Currency.setTitle(country.currency, for: .normal)
        }
    }
    
    @IBAction func providerType(_ sender: UIButton) {
        APIPartnerType.showAlertIn(vc: self) { provider in
            sender.setTitle(provider.title, for: .normal)
            self.tableView.beginUpdates()
            self.carTypeTableViewCell.isHidden = provider != .driver
            self.CarCell.isHidden = provider != .driver
            self.HaveAcarCell.isHidden = provider != .driver
            self.PhysiotherapistCell.isHidden = provider != .therapist
            self.PsychologistCell.isHidden = provider != .therapist
            self.OccupationalCell.isHidden = provider != .therapist
            self.SocialCell.isHidden = provider != .therapist
            self.recreationalCell.isHidden = provider != .therapist
            self.CounselingCell.isHidden = provider != .therapist
            self.EducationCell.isHidden = provider != .therapist
            self.medicationTypeTableViewCell.isHidden = provider != .therapist
            if provider != .driver {
                self.TimeCell.isHidden = false
            }
            
            self.SpeachCel.isHidden = provider != .therapist
            
            self.InHospitalCell.isHidden = provider != .partner
            self.ExamsCell.isHidden = provider != .partner
            self.InHomeCell.isHidden = provider != .partner
            self.DailyCell.isHidden = provider != .partner
            self.StudyingCell.isHidden = provider != .partner

            self.tableView.endUpdates()
        }
        ServiceTypes.removeAll()
    }
    
  
    @IBAction func medicationType(_ sender: UIButton) {
        /*
        APITherapistType.showAlertIn(vc: self) { joining in
            sender.setTitle(joining.title, for: .normal)
        }
 */
    }
    // Change CheckBoxes Image
    var isChecked = false
    func ChangeCheckBoxImage(CheckBox:UIButton)->Bool {
        if isChecked == false {
            CheckBox.setImage(#imageLiteral(resourceName: "Check"), for: .normal)
            
        }else {
            CheckBox.setImage(#imageLiteral(resourceName: "UnCheck"), for: .normal)
        }
        isChecked = !isChecked
        return isChecked
    }
    // End Of CheckBox Image
    
    
// Therapist Actions
    
    // أخصاشى علاج طبيعى
    
    var Physiotherapist : String! = ""

    @IBAction func PhysiotherapistBu(_ sender: UIButton){
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            Physiotherapist = self.PhysiotherapistText.text
        }else{
            Physiotherapist = ""
        }
    }
   // أخصائى نفسى
    var Psychologist:String! = ""
    @IBAction func PsychologistBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            Psychologist = self.PsychologistText.text
        }else{
            Psychologist = ""

        }
    }
    // أخصائى علاج وظيفى
    var Occupational : String! = ""
    @IBAction func OccupationalBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            Occupational = self.OccupationalText.text

        }else{
            Occupational = ""

        }

    }
    
    // أخصائى إجتماعى
    var Social : String! = ""
    @IBAction func SocialBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            Social = self.SocialText.text
        }else{
            Social = ""
        }
    }
    // أخصائى تخاطب
    var Speech : String! = ""
    @IBAction func SpeechBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            Speech = self.SpeechText.text
        }else{
            Speech = ""
        }
    }
    // أخصائى علاج ترويحى
    
    var recreational : String! = ""
    @IBAction func recreationalBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            recreational = self.recreationalText.text
        }else{
            recreational = ""
        }
    }
    // أخصائى إرشاد وتوجيه أسرى 
    var Counseling : String! = ""
    
    @IBAction func CounselingBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            Counseling = self.CounselingText.text
        }else{
            Counseling = ""
        }
    }
    // معلم صعوبات تعلم
    var education : String! = ""
    
    @IBAction func educationBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            education = self.educationText.text
        }else{
            education = ""
        }

    }
    // End Of Therapist
    
    // المرافق   
    // In Hospital
    var inhospital :String! = ""

    @IBAction func InHospitalBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            inhospital = self.inHospitalText.text
        }else{
            inhospital = ""
        }

    }
    
    // Exams
    var exams : String! = ""

    @IBAction func ExamsBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            exams = self.ExamsLabel.text
        }else{
            exams = ""
        }
    }
// In Home
    var inhome : String! = ""

    @IBAction func InHomeBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            inhome = self.InHomeText.text
        }else{
            inhome = ""
        }

    }
    // Daily
    var daily :String! = ""

    @IBAction func DailyBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            daily = self.DailyText.text
        }else{
            daily = ""
        }

    }
    
    // Study
    
    var study :String! = ""
    @IBAction func StudyBu(_ sender: UIButton) {
        if self.ChangeCheckBoxImage(CheckBox: sender) == true {
            study = self.StudyText.text
        }else{
            study = ""
        }

    }
    // End Of المرافق
    
   
    var didAccept = false
    @IBAction func acceptTerms(_ sender: UIButton) {
        sender.setImage(self.didAccept ? #imageLiteral(resourceName: "Check") : #imageLiteral(resourceName: "UnCheck"), for: .normal)
        self.didAccept = !self.didAccept
    }
    var ServiceTypes : [String]! = []
    // Check If Button Is Checked And Add It's Value to Service Type Array
    func CheckedButton(){
        // المعالج
        if self.Physiotherapist != "" {
            self.ServiceTypes.append("" + self.Physiotherapist + "")
        }
        
        if self.Psychologist != "" {
            self.ServiceTypes.append("" + self.Psychologist + "")
        }
        
        if self.Occupational != "" {
            self.ServiceTypes.append("" + self.Occupational + "")
        }
        
        if self.Social != "" {
            self.ServiceTypes.append("" + self.Social + "")
        }
        
        if self.Speech != "" {
            self.ServiceTypes.append("" + self.Speech + "")
        }
        
        if self.recreational != "" {
            self.ServiceTypes.append("" + self.recreational + "")
        }
        
        if self.Counseling != "" {
            self.ServiceTypes.append("" + self.Counseling + "")
        }
        
        if self.education != "" {
            self.ServiceTypes.append("" + self.education + "")
        }
        
        // المرافق
        if self.inhospital != "" {
            self.ServiceTypes.append("" + self.inhospital + "")
        }
        
        if self.exams != "" {
            self.ServiceTypes.append("" + self.exams + "")
        }
        
        if self.inhome != "" {
            self.ServiceTypes.append("" + self.inhome + "")
        }
        
        if self.daily != "" {
            self.ServiceTypes.append("" + daily + "")
        }
        if self.study != "" {
            self.ServiceTypes.append("" + study + "")
        }

    }
    // Driver
    
    @IBAction func HaveAcarBu(_ sender: UIButton) {
        APICar.showAlertIn(vc: self) { car in
            sender.setTitle(car.title, for: .normal)
        }
    }
    
    @IBAction func CarBu(_ sender: UIButton) {
        APICar.showAlertIn(vc: self) { car in
            sender.setTitle(car.title, for: .normal)
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        CheckedButton()
       
        guard self.selectedCountry != nil else {
            return
        }
        
        guard !self.didAccept else {
            self.showAlert(title: "يجب عليك الموافقة علي شروط التطبيق أولا", message: "")
            return
        }
        
        sender.showActivityIndicator()
         /*
        var serviceKind = self.carTypeTextField.text!
        if serviceKind == "" {
            serviceKind = self.medicationTypeButton.titleLabel!.text!
        }
        */
        APIHelper.registerProvider(name: self.nameTextField.text!, mobile: mobileTextField.text!, gender: (genderButton.titleLabel?.text!)!, country: (countryButton.titleLabel?.text)!, city: CityText.text!, salary:"", mail: mailTextField.text!, password: passwordTextField.text!, serviceType: (serviceTypeButton.titleLabel?.text)!, serviceKind: ServiceTypes, car_type : self.carTypeTextField.text!,qualifier: (self.CarButton.titleLabel?.text!)!, phoenecode: self.CountryKey.text! ,image: self.userImageView.image) { (status) in
            print(status)
            if status.isSuccess {
                self.segueToMainTabBar()
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
 
    }
    
    @IBAction func PrividerFileBu(_ sender: UIButton) {
        let fileMngr=FileManager.default;
        func listFilesFromDocumentsFolder()->[String]?{
            //full path to documents directory
            let docs=fileMngr.urls(for: .documentDirectory,in: .userDomainMask)[0].path;
            //list all contents of directory and return as [String] OR nil if failed
            return try? fileMngr.contentsOfDirectory(atPath:docs);
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


extension RegisterProviderTableViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.dismiss(animated: true, completion: {
            self.userImageView.image = image
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
