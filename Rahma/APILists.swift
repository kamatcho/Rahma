//
//  AMCountries.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/3/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct APICountry {
    var id: String!
    var ar: String!
    var en: String!
    var code: String!
    var image: String!
    var Key : String!
    var currency : String!
    
    var name: String! {
        return self.isAr ? self.ar : self.ar
    }
    
    let isAr = Locale.preferredLanguages.first == "ar"
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.ar = json["ar"].stringValue
        self.en = json["en"].stringValue
        self.code = json["code"].stringValue
        self.image = json["image"].stringValue
        self.Key = json["phonecode"].stringValue
        self.currency = json["Currency"].stringValue
    }
    
    static func parseCountries(json: JSON) -> [APICountry] {
        var countries = [APICountry]()
        for country in json.arrayValue {
            countries.append(APICountry(json: country))
        }
        return countries
    }
    
    static func showCountriesIn(vc: UIViewController, sender: UIButton, completion: @escaping (_ country: APICountry) -> ()) {
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let countriesNav = storyboard.instantiateViewController(withIdentifier: "CountriesTableViewController") as! UINavigationController
        let countriesTVC = countriesNav.viewControllers.first! as! CountriesTableViewController
        countriesTVC.completion = completion
        
        vc.present(countriesNav, animated: true, completion: nil)
    }
    
}

class APICountryPresenter: NSObject, UIPopoverPresentationControllerDelegate {
    
    func showCountriesIn(vc: UIViewController, sender: UIButton, completion: @escaping (_ country: APICountry) -> ()) {
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let countriesNav = storyboard.instantiateViewController(withIdentifier: "CountriesTableViewController") as! UINavigationController
        let countriesTVC = countriesNav.viewControllers.first! as! CountriesTableViewController
        countriesTVC.completion = completion
        
        countriesNav.modalPresentationStyle = .popover
        countriesNav.preferredContentSize = CGSize(width: vc.view.frame.width - 40, height: 300)
        
        let popover = countriesNav.popoverPresentationController!
        popover.delegate = self
        popover.sourceView = sender
        popover.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY , width: 0, height: 0)
        popover.permittedArrowDirections = [.up, .down]
        
        vc.present(countriesNav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}


enum APICenterType: Int {
    case governmentHospital, privateHospital, treatmentCenter
    
    private static let count = 2
    
    var title: String {
        switch self {
        case .governmentHospital: return "مستشفي حكومية"
        case .privateHospital: return "مستشفي خاصة"
        case .treatmentCenter: return "مركز علاج"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ country: APICenterType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APICenterType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}



enum APIPartnerType: Int {
    case driver, partner, therapist
    
    private static let count = 3
    
    var title: String {
        switch self {
        case .driver: return "سائق"
        case .partner: return "مرافق"
        case .therapist: return "معالج"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ country: APIPartnerType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIPartnerType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIProviderType : Int {
    case volunteer , withpay
    private static let count = 2
    var title: String {
        switch self {
        case .volunteer:
            return "متطوع"
        case .withpay :
            return "مقابل مادى"
        }
    }
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ country: APIProviderType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIProviderType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APITherapistType: Int {
    case Physiotherapist, Psychologist, Occupational, Social, Speech, recreational,Counseling,education
    
    private static let count = 8
    
    var title: String {
        switch self {
        case .Physiotherapist :
            return "أخصائى علاج طبيعى"
        case .Psychologist :
            return "أخصائى نفسى"
        case .Occupational :
            return "علاج وظيفى"
        case .Social :
            return "أخصائى إجتماعى"
        case .Speech :
            return "أخصائى نطق وتخاطب"
        case .recreational :
            return "أخصائى علاج ترويجى"
        case .Counseling :
            return "أخصائى إرشاد وتوجيه أسرى"
        case .education :
            return "معلم صعوبات تعلم"
            
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ country: APITherapistType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APITherapistType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}


enum APICar : Int {
    case No , Yes
    private static let count = 2
    
    var title :String {
        switch self {
        case .Yes:
            return "نعم"
        case.No :
            return "لا"
        }
    }
        static func showAlertIn(vc: UIViewController, completion: @escaping (_ country: APICar) -> ()) {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            for index in 0...self.count {
                if let item = APICar.init(rawValue: index) {
                    alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                        completion(item)
                    }))
                }
            }
            alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
}

enum APIGender: Int {
    case male, female
    
    private static let count = 3
    
    var title: String {
        switch self {
        case .male: return "ذكر"
        case .female: return "مؤنث"
        }
    }
    
    var value: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ country: APIGender) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIGender.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIRestaurantType: Int {
    case restaurants, coffeShop
    
    private static let count = 1
    
    var title: String {
        switch self {
        case .restaurants: return "المطاعم"
        case .coffeShop: return "كوفي شوب"
        }
    }
    
    var value: String {
        switch self {
        case .restaurants: return "Restaurants"
        case .coffeShop: return "CoffeShop"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIRestaurantType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIRestaurantType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIRestaurantOptions: Int {
    case locale, delivery, both
    
    private static let count = 2
    
    var title: String {
        switch self {
        case .locale: return "محلي"
        case .delivery: return "سفري"
        case .both: return "محلي و سفري"
        }
    }
    
    var value: String {
        switch self {
        case .locale: return "Locale"
        case .delivery: return "Delivery"
        case .both: return "Locale & Delivery"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIRestaurantOptions) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIRestaurantOptions.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIRestaurantServiceType: Int {
    case mens, womens, families, all
    
    private static let count = 3
    
    var title: String {
        switch self {
        case .mens: return "رجال"
        case .womens: return "نساء"
        case .families: return "عوائل"
        case .all: return "جميع الأشخاص"
        }
    }
    
    var value: String {
        switch self {
        case .mens: return "mens"
        case .womens: return "womens"
        case .families: return "families"
        case .all: return "All"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIRestaurantServiceType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIRestaurantServiceType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
//
enum APIProvider : Int {
    case InHospital , Exams , Daily , Study, InHome
    
    private static let count = 5
    
    var title : String {
        switch self {
        case .InHospital:
            return "مرافق فى المستشفى"
        case .Exams:
            return "مرافق لأداء الإختبارات"
        case .Daily:
            return "مرافق لعلاج يومى"
        case .Study :
            return "مرافقى للدراسة"
        case .InHome:
            return "مرافق فى المنزل"
            
       
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIProvider) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIProvider.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIPlaceType: Int {
    case entertainments, educations
    
    private static let count = 1
    
    var title: String {
        switch self {
        case .entertainments: return "ترفيهي"
        case .educations: return "تعليمي"
        }
    }
    
    var value: String {
        switch self {
        case .entertainments: return "Entertainments"
        case .educations: return "Educations"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIPlaceType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIPlaceType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIPlaceServiceType: Int {
    case shop, center, garden
    
    private static let count = 2
    
    var title: String {
        switch self {
        case .shop: return "محل"
        case .center: return "مركز"
        case .garden: return "حديقة"
        }
    }
    
    var value: String {
        switch self {
        case .shop: return "Shop"
        case .center: return "Center"
        case .garden: return "Garden"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIPlaceServiceType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIPlaceServiceType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

enum APIEventType: Int {
    case event, seminar, conference, course, workshop
    
    private static let count = 4
    
    var title: String {
        switch self {
        case .event: return "فعالية"
        case .seminar: return "ندوة"
        case .conference: return "مؤتمر"
        case .course: return "دورة"
        case .workshop: return "ورشة عمل"
        }
    }
    
    var value: String {
        switch self {
        case .event: return "Event"
        case .seminar: return "Seminar"
        case .conference: return "Conference"
        case .course: return "Course"
        case .workshop: return "Workshop"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIPlaceServiceType) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIPlaceServiceType.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
enum APIConnectionStatus :Int {
    case online , offline
    private static let count = 2
    var title : String {
        switch self {
        case .online:
            return "متصل"
        case .offline :
            return "غير متصل"
        }
    }
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIConnectionStatus) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIConnectionStatus.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

}

enum APIWorkStatus : Int {
    case volunteer , withPay
    private static let count = 2
    var title : String {
        switch self {
        case .volunteer:
            return "تطوع"
        case .withPay :
            return "بمقابل"
        }
    }
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APIWorkStatus) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APIWorkStatus.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

}

enum APINumberOfPationt :Int {
    case one , two , three , four , five
    private static let count = 5
    var title : String {
        switch self {
        case .one:
            return "1"
        case .two :
            return "2"
        case .three :
            return "3"
        case . four :
            return "4"
        case .five :
            return "5"
        }
    }
    
    static func showAlertIn(vc: UIViewController, completion: @escaping (_ _: APINumberOfPationt) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        for index in 0...self.count {
            if let item = APINumberOfPationt.init(rawValue: index) {
                alert.addAction(UIAlertAction.init(title: item.title, style: .default, handler: { action in
                    completion(item)
                }))
            }
        }
        alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

}


enum APIRequestType: Int {
    case therapists, drivers, partners , events, resturants, entertainments
    
    var title: String {
        switch self {
        case .drivers: return "السائقين"
        case .partners: return "المرافقين"
        case .therapists: return "المعالجين"
        case .events: return "فعاليات"
        case .entertainments: return "الملاهي"
        case .resturants: return "المطاعم"
        }
    }
    
    var value: String {
        switch self {
        case .drivers: return "Drivers"
        case .partners: return "Partners"
        case .therapists: return "Therapists"
        case .events: return "Events"
        case .entertainments: return "Entertainments"
        case .resturants: return "Resturants"
        }
    }
    
    var image: UIImage {
        switch self {
        case .drivers: return #imageLiteral(resourceName: "Driver")
        case .partners: return #imageLiteral(resourceName: "Attendant")
        case .therapists: return #imageLiteral(resourceName: "Medicative")
        case .events: return #imageLiteral(resourceName: "EquipedCar")
        case .entertainments: return #imageLiteral(resourceName: "Entertainments")
        case .resturants: return #imageLiteral(resourceName: "Restaurants")
        }
    }
    
    var color: UIColor {
        switch self {
        case .therapists: return #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        case .partners: return #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        case .drivers: return #colorLiteral(red: 0.1019607843, green: 0.737254902, blue: 0.6117647059, alpha: 1)
        case .events: return #colorLiteral(red: 0.6078431373, green: 0.3490196078, blue: 0.7137254902, alpha: 1)
        case .entertainments: return #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)
        case .resturants: return #colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1)
        }
    }
}
