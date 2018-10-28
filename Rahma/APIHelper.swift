import Foundation
import Alamofire
import SwiftyJSON

struct AMError: LocalizedError {
    var localizedDescription: String
    
    init(str: String) {
        self.localizedDescription = str
    }
}

enum APIRouter : URLRequestConvertible {
    
    static let host = "http://taahel.com/"

    
    // User
    case loginUser(mail: String, password: String)
    
    case registerPatient(name: String, mobile: String, age: String, city: String, gender: String, country: String, mail: String, password: String,phonecode:String)
    
    case registerProvider(name : String , mobile: String , gender: String , country :String , city: String ,salary : String , mail :String , password : String ,serviceType : String ,serviceKind : [String] ,car_type : String,qualifier : String , phonecode:String)
    
    case registerCenter(name: String, mobile: String, address: String, city: String, country: String, centerType: String, website: String, mail: String, password: String , phonecode:String)
    
    case registerCompany(name: String, mobile: String, address: String, city: String, country: String, website: String, mail: String, password: String, phonecode : String)
    
    case addPlace(name: String, mobile: String, address: String, city: String, country: String, placeType: String, serviceType: String,email:String ,phonecode: String,password: String)
    
    case addRestaurant(name: String, mobile: String, address: String, city: String, country: String, restaurantType: String, restaurantOptions: String, serviceType: String,email: String,phonecode:String , password: String)
    
    case resetPassword(mail: String)
    
    case updateStatus(id: String, kind: String, working: String , available : String)
    
    case getCountries
    case getAllCountries
    
    case getGovernmentsHospitals(country: String)
    case getPrivateHospitals(country: String)
    case getCentersHospitals(country: String)
    
    case getDontaionDevices(country: String)
    case getSaleDevices(country: String)
    case getRentDevices(country: String)
    
    case getTherapists
    case getPartners
    case getDrivers
    case getEvents
    case getRestaurants
    case getEntertainments
    
    case getEnquiries
    case addEnquiry(title: String)
    
    case getExperiences
    case addExperience(id: String, kind: String, country: String, doctor: String, hospital: String, body: String)
    
    case addDevice(id: String, kind: String, type: String, price: String, description: String)
    
    case updateProfileImage(id: String, kind: String)
    
    var method : Alamofire.HTTPMethod {
        return .post
    }
    
    var fullPath : String {
        print(APIRouter.host + self.path.removeWhitespaces().encode())
        return APIRouter.host + self.path.removeWhitespaces().encode()
    }
    
    var path : String {
        switch self {
        case .loginUser: return "login"
        case .registerPatient: return "registerPatient"
        case .registerProvider: return "registerProvider"
        case .registerCenter: return "registerCenter"
        case .addPlace: return "addPlace"
        case .addRestaurant: return "addRestaurant"
        case .registerCompany: return "companies"
            
        case .resetPassword: return "resetPassword"
            
        case .getCountries: return "countries"
        case .getAllCountries: return "allCountries"
            
        case .getGovernmentsHospitals: return "governments"
        case .getPrivateHospitals: return "privates"
        case .getCentersHospitals: return "centers"
            
        case .getDontaionDevices: return "donations"
        case .getSaleDevices: return "sales"
        case .getRentDevices: return "rents"
            
        case .getTherapists: return "therapists"
        case .getPartners: return "partners"
        case .getDrivers: return "drivers"
        case .getEvents: return "cars"
        case .getRestaurants: return "restaurants"
        case .getEntertainments: return "entertainments"
            
        case .getEnquiries: return "enquiries"
        case .addEnquiry: return "addEnquiry"
            
        case .getExperiences: return "experiences"
        case .addExperience: return "addExperience"
            
        case .addDevice: return "addDevice"
            
        case .updateProfileImage: return "profileImage"
            
        case .updateStatus: return "status"
        }
    }
    
    var parameters : Parameters? {
        switch self {
            // Membership
            
        case .loginUser(let mail, let password) :
            return ["mail": mail, "password": password]
            
        case .registerPatient(let name, let mobile, let age, let city, let gender, let country, let mail,let phonecode ,let password):
            return ["name": name, "mobile": mobile, "age": age, "city": city, "gender": gender, "country": country, "mail": mail,"phonecode": phonecode ,"password": password]
  // name : String , mobile: String , gender: String , country :String , city: String ,salary : String , mail :String , password : String ,serviceType : String ,serviceKind : String ,qualifier : Int
        case .registerProvider( let name, let mobile, let gender, let country ,let city, let salary,let mail,let password, let serviceType, let serviceKind, let car_type ,let qualifier, let phonecode):
            return ["name" : name , "mobile" :mobile , "gender": gender , "country" :country , "city" : city , "salary" : salary , "mail" : mail , "password" :password , "serviceType" :serviceType , "serviceKind" :serviceKind ,"car_type":car_type ,"qualifier" : qualifier , "phonecode" : phonecode]
            
        case .registerCenter(let name, let mobile, let address, let city, let country, let centerType, let website, let mail, let password, let phonecode):
            return ["name": name, "mobile": mobile, "address": address, "city": city, "country": country, "centerType": centerType, "website": website, "mail": mail, "password": password,"phonecode":phonecode]
            
        case .registerCompany(let name, let mobile, let address, let city, let country, let website, let mail, let phonecode ,let password):
            return ["name": name, "mobile": mobile, "address": address, "city": city, "country": country, "website": website, "mail": mail,"phonecode":phonecode ,"password": password]
            
        case .addPlace(let name, let mobile, let address, let city, let country, let placeType, let serviceType,let email ,let phonecode,let password):
            return ["name": name, "mobile": mobile, "address": address, "city": city, "country": country, "placeType": placeType, "serviceType": serviceType, "email":email, "phonecode":phonecode,"password": password]
            
        case.addRestaurant(let name, let mobile, let address, let city, let country, let restaurantType, let restaurantOptions, let serviceType, let email,let phonecode,let password):
            return ["name": name, "mobile": mobile, "address": address, "city": city, "country": country, "restaurantType": restaurantType, "restaurantOptions": restaurantOptions, "serviceType": serviceType,"email":email ,"phonecode":phonecode,"password": password]
            
        case .resetPassword(let mail) :
            return ["mail": mail]
            
        case .getCountries:
            return [:]
            
        case .getAllCountries:
            return [:]
            
        case .getGovernmentsHospitals(let country): return ["country": country]
        case .getPrivateHospitals(let country): return ["country": country]
        case .getCentersHospitals(let country): return ["country": country]
            
        case .getDontaionDevices(let country): return ["country": country]
        case .getSaleDevices(let country): return ["country": country]
        case .getRentDevices(let country): return ["country": country]
            
        case .getTherapists: return [:]
        case .getPartners: return [:]
        case .getDrivers: return [:]
        case .getEvents: return [:]
        case .getRestaurants: return [:]
        case .getEntertainments: return [:]
            
        case .getEnquiries: return [:]
        case .addEnquiry(let title): return ["title": title]
            
        case .getExperiences: return [:]
        case .addExperience(let id, let kind, let country, let doctor, let hospital, let body):
            return ["id": id, "kind": kind, "country": country, "doctor": doctor, "hospital": hospital, "body": body]
            
        case .addDevice(let id, let kind, let type, let price, let description):
            return ["id": id, "kind": kind, "priceType": type, "price": price, "description": description]
            
        case .updateProfileImage(let id, let kind):
            return ["id": id, "kind": kind]
            
        case .updateStatus(let id, let kind, let working , let available): return ["id": id, "kind": kind, "working": working , "available" : available]
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let ulr = URL(string: self.fullPath)
        var mutableRequest = URLRequest(url: ulr!)
        mutableRequest.httpMethod = self.method.rawValue
        
        mutableRequest.timeoutInterval = TimeInterval(10 * 1000)
        if self.method == .post {
            print(self.parameters ?? "No Parameters")
            return try URLEncoding.default.encode(mutableRequest, with: parameters)
        } else {
            return mutableRequest
        }
    }
    
}

class APIHelper : NSObject {
    
    // MARK:- User
    
    typealias APIStatusCompletion = (_ status: APIStatus) -> ()
    typealias APIUserCompletion = (_ status: APIStatus, _ user: APIUser?) -> ()
    typealias APICountryCompletion = (_ status: APIStatus, _ countries: [APICountry]?) -> ()
    typealias APIEnquiryCompletion = (_ status: APIStatus, _ countries: [APIEnquiry]?) -> ()
    
    
    class func loginUser(mail: String, password: String, completion: @escaping APIUserCompletion) {
        
        Alamofire.request(APIRouter.loginUser(mail: mail, password: password))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    let user = APIUser(json: response.result)
                    user.saveUserToDefaults()
                    completion(response.status, user)
                } else {
                    completion(response.status, nil)
                }
        }
        
    }
    
    class func registerPatient(name: String, mobile: String, age: String, city: String, gender: String, country: String, mail: String, password: String, phonecode:String,image: UIImage?, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.registerPatient(name: name, mobile: mobile, age: age, city: city, gender: gender, country: country, mail: mail, password: password, phonecode : phonecode))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    let user = APIUser(json: response.result)
                    if image != nil {
                    APIHelper.updateProfileImage(id: user.id, kind: user.kind, image: image, completion: { (status, user) in
                        if status.isSuccess {
                            user?.saveUserToDefaults()
                            completion(status)
                        } else {
                            completion(status)
                        }
                    })
                    } else {
                        user.saveUserToDefaults()
                        completion(response.status)
                    }
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    class func registerProvider(name: String, mobile: String, gender: String, country: String, city: String, salary: String, mail: String, password: String, serviceType: String, serviceKind: [String], car_type :String,qualifier: String ,phoenecode:String,image: UIImage?, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.registerProvider(name:name, mobile: mobile, gender: gender, country: country, city: city, salary: salary, mail: mail, password: password, serviceType: serviceType, serviceKind: serviceKind,car_type: car_type ,qualifier: qualifier, phonecode: phoenecode))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    let user = APIUser(json: response.result)
                    if image != nil {
                        APIHelper.updateProfileImage(id: user.id, kind: user.kind, image: image, completion: { (status, user) in
                            if status.isSuccess {
                                user?.saveUserToDefaults()
                                completion(status)
                            } else {
                                completion(status)
                            }
                        })
                    } else {
                        user.saveUserToDefaults()
                        completion(response.status)
                    }
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    class func registerCenter(name: String, mobile: String, address: String, city: String, country: String, centerType: String, website: String, mail: String,phonecode: String ,password: String, image: UIImage?, completion: @escaping APIUserCompletion) {
        
        Alamofire.request(APIRouter.registerCenter(name: name, mobile: mobile, address: address, city: city, country: country, centerType: centerType, website: website, mail: mail, password: password , phonecode: phonecode))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    let user = APIUser(json: response.result)
                    if image != nil {
                        APIHelper.updateProfileImage(id: user.id, kind: user.kind, image: image, completion: { (status, user) in
                            if status.isSuccess {
                                completion(status, user)
                            } else {
                                completion(status, nil)
                            }
                        })
                    } else {
                        completion(response.status, user)
                    }
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func registerCompany(name: String, mobile: String, address: String, city: String, country: String, website: String, mail: String, password: String,phonecode : String, image: UIImage?, completion: @escaping APIUserCompletion) {
        
        Alamofire.request(APIRouter.registerCompany(name: name, mobile: mobile, address: address, city: city, country: country, website: website, mail: mail,password: password ,phonecode :phonecode))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    let user = APIUser(json: response.result)
                    if image != nil {
                        APIHelper.updateProfileImage(id: user.id, kind: user.kind, image: image, completion: { (status, user) in
                            if status.isSuccess {
                                completion(status, user)
                            } else {
                                completion(status, nil)
                            }
                        })
                    } else {
                        completion(response.status, user)
                    }
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func resetPassword(mail: String, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.resetPassword(mail: mail))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(APIStatus.init(isSuccess: true))
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    class func updateStatus(id: String, kind: String, working: String,availble : String, completion: @escaping APIUserCompletion) {
        
        Alamofire.request(APIRouter.updateStatus(id: id, kind: kind, working: working, available: availble) ).responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    let user = APIUser(json: response.result)
                    user.saveUserToDefaults()
                    completion(response.status, user)
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func getCountries(completion: @escaping APICountryCompletion) {
        
        Alamofire.request(APIRouter.getCountries)
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    
                    completion(response.status, APICountry.parseCountries(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func getAllCountries(completion: @escaping APICountryCompletion) {
        
        Alamofire.request(APIRouter.getAllCountries)
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    
                    completion(response.status, APICountry.parseCountries(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    typealias APIHospitalsCompletion = (_ : APIStatus, _ : [APIHospital]?) -> ()
    class func getHospitals(type: APICenterType, country: String,completion: @escaping APIHospitalsCompletion) {
        
        var routerType = APIRouter.getGovernmentsHospitals
        
        switch type {
        case APICenterType.governmentHospital:
            routerType = APIRouter.getGovernmentsHospitals
        case APICenterType.privateHospital:
            routerType = APIRouter.getPrivateHospitals
        case APICenterType.treatmentCenter:
            routerType = APIRouter.getCentersHospitals
        }
        
        Alamofire.request(routerType(country: country))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status, APIHospital.parseHospitals(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    typealias APIRequestsCompletion = (_ : APIStatus, _ : [APIRequest]?) -> ()
    class func getRequests(type: APIRequestType, completion: @escaping APIRequestsCompletion) {
        
        var routerType: APIRouter!
        
        switch type {
        case APIRequestType.therapists:
            routerType = APIRouter.getTherapists
        case APIRequestType.partners:
            routerType = APIRouter.getPartners
        case APIRequestType.drivers:
            routerType = APIRouter.getDrivers
        case APIRequestType.events:
            routerType = APIRouter.getEvents
        case APIRequestType.resturants:
            routerType = APIRouter.getRestaurants
        case APIRequestType.entertainments:
            routerType = APIRouter.getEntertainments
        }
        
        Alamofire.request(routerType)
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status, APIRequest.parseRequests(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    typealias APIDevicesCompletion = (_ : APIStatus, _ : [APIDevice]?) -> ()
    class func getDevices(type: APIDeviceType, country: String,completion: @escaping APIDevicesCompletion) {
        
        var routerType = APIRouter.getDontaionDevices
        
        switch type {
        case APIDeviceType.donation:
            routerType = APIRouter.getDontaionDevices
        case APIDeviceType.sale:
            routerType = APIRouter.getSaleDevices
        case APIDeviceType.rent:
            routerType = APIRouter.getRentDevices
        }
        
        Alamofire.request(routerType(country: country))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status, APIDevice.parseDevices(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func getEnquiries(completion: @escaping APIEnquiryCompletion) {
        
        Alamofire.request(APIRouter.getEnquiries)
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status, APIEnquiry.parseEnquiries(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func addEnquiry(title: String, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.addEnquiry(title: title))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(APIStatus.init(isSuccess: true))
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    typealias APIExperienceCompletion = (_ status: APIStatus, _ countries: [APIExperience]?) -> ()
    class func getExperiences(completion: @escaping APIExperienceCompletion) {
        
        Alamofire.request(APIRouter.getExperiences)
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status, nil)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status, APIExperience.parseExperiences(json: response.result))
                } else {
                    completion(response.status, nil)
                }
                
        }
        
    }
    
    class func addExperience(id: String, kind: String, country: String, doctor: String, hospital: String, body: String, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.addExperience(id: id, kind: kind, country: country, doctor: doctor, hospital: hospital, body: body))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(APIStatus.init(isSuccess: true))
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    class func addPlace(name: String, mobile: String, address: String, city: String, country: String, placeType: String, serviceType: String,email : String ,phonecode:String,password: String, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.addPlace(name: name, mobile: mobile, address: address, city: city, country: country, placeType: placeType, serviceType: serviceType, email: email , phonecode :phonecode ,password: password))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status)
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    class func addRestaurant(name: String, mobile: String, address: String, city: String, country: String, restaurantType: String, restaurantOptions: String, serviceType: String,email :String,phonecode:String, password: String, completion: @escaping APIStatusCompletion) {
        
        Alamofire.request(APIRouter.addRestaurant(name: name, mobile: mobile, address: address, city: city, country: country, restaurantType: restaurantType, restaurantOptions: restaurantOptions, serviceType: serviceType,email: email,phonecode:phonecode, password: password))
            .responseJSON { dataResponse in
                
                guard dataResponse.result.error == nil else {
                    let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                    completion(status)
                    return
                }
                
                let response = APIResponse(json: JSON(dataResponse.result.value!))
                
                if response.status.isSuccess {
                    completion(response.status)
                } else {
                    completion(response.status)
                }
                
        }
        
    }
    
    typealias APIProgressHandlerCompletion = (_ : Double) -> ()
    class func addDevice(id: String, kind: String, type: String, price: String, description: String, image: UIImage?, completion: @escaping APIStatusCompletion, progressHandler: @escaping APIProgressHandlerCompletion) {
        
        Alamofire.upload(multipartFormData: { (mfd) in
            if let image = image {
                if let data = UIImageJPEGRepresentation(image, 1.0) {
                    mfd.append(data, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
            
            for (key,value) in APIRouter.addDevice(id: id, kind: kind, type: type, price: price, description: description).parameters! {
                mfd.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
            
        }, with: APIRouter.addDevice(id: id, kind: kind, type: type, price: price, description: description)) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _) :
                upload.responseJSON(completionHandler: { (dataResponse) in
                    
                    guard dataResponse.result.error == nil else {
                        let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                        completion(status)
                        return
                    }
                    
                    let response = APIResponse(json: JSON(dataResponse.result.value!))
                    
                    if response.status.isSuccess {
                        completion(APIStatus.init(isSuccess: true))
                    } else {
                        completion(response.status)
                    }
                    
                })
                
                upload.uploadProgress(closure: { (progress) in
                    progressHandler(progress.fractionCompleted)
                })
                
            case .failure(let error) :
                let status = APIStatus(isSuccess: false, message: error.localizedDescription)
                completion(status)
            }
            
        }
        
    }
    
    class func updateProfileImage(id: String, kind: String, image: UIImage?, completion: @escaping APIUserCompletion) {
        
        Alamofire.upload(multipartFormData: { (mfd) in
            if let image = image {
                if let data = UIImageJPEGRepresentation(image, 1.0) {
                    mfd.append(data, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
            
            for (key,value) in APIRouter.updateProfileImage(id: id, kind: kind).parameters! {
                mfd.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
            
        }, with: APIRouter.updateProfileImage(id: id, kind: kind)) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _) :
                upload.responseJSON(completionHandler: { (dataResponse) in
                    
                    guard dataResponse.result.error == nil else {
                        let status = APIStatus(isSuccess: false, message: dataResponse.result.error!.localizedDescription)
                        completion(status, nil)
                        return
                    }
                    
                    let response = APIResponse(json: JSON(dataResponse.result.value!))
                    
                    if response.status.isSuccess {
                        let user = APIUser(json: response.result)
                        completion(APIStatus.init(isSuccess: true), user)
                    } else {
                        completion(response.status, nil)
                    }
                    
                })
                
            case .failure(let error) :
                let status = APIStatus(isSuccess: false, message: error.localizedDescription)
                completion(status, nil)
            }
            
        }
        
    }
    // MARK:- My Search Functions
    // Pationt Search
    class func PationtSerach(serviceKind : String , country : String , city : String, time: String ,date:String, address: String , status_kind: String, complition : @escaping (_ error : Error?)->Void) {
        let url = URL(string: "http://taahel.com/therapists")!
            let parameters = [
                "serviceKind" : serviceKind,
                "country" : country,
                "city" : city,
                "time" : time,
                "date" : date,
                "address" : address,
                "status_kind" :status_kind
                ] as [String : Any]
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                switch response.result {
                case.failure(let error):
                    
                    complition(error)
                    print(error)
                case .success(let value):
                    complition(nil)
                    
                    var Providers = [SearchModel]()
                    
                    let json = JSON(value)
                    if let data = json["data"].array {
                        for obj in data {
                            if let obj = obj.dictionary {
                                let provider = SearchModel(Data: obj)
                                Providers.append(provider)
                            }
                        }
                    }
                    
                    break
                }
            })
  
    }
    

    // Provider Search
    class func ProviderSearch(serviceKind : String , country : String , city : String, time: String ,date:String, address: String , status_kind: String, complition : @escaping (_ error : Error?)->Void){
        let url = URL(string: "http://taahel.com/partners")!
        
        let parameters = [
            "serviceKind" : serviceKind,
            "country" : country,
            "city" : city,
            "time" : time,
            "date" : date,
            "address" : address,
            "status_kind" :status_kind
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case.failure(let error):

                complition(error)
                print(error)
            case .success(let value):
                complition(nil)
                
                var Providers = [SearchModel]()

                let json = JSON(value)
                if let data = json["data"].array {
                    for obj in data {
                        if let obj = obj.dictionary {
                            let provider = SearchModel(Data: obj)
                            Providers.append(provider)
                        }
                    }
                }
                
                break
            }
        })
        
    }

    // Driver Search
    class func DriverSearch(serviceKind : String , country : String ,city : String , time : String , date : String , qualifier : String , address : String , status_kind : String , complition : @escaping (_ error : Error?)->Void){
        let url = URL(string: "http://taahel.com/drivers")!
        let parameters = [
            "serviceKind" : serviceKind,
            "country" : country,
            "city" : city,
            "time" : time,
            "date" : date,
            "address" : address,
            "status_kind" :status_kind ,
            "qualifier" : qualifier
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case.failure(let error):
                
                complition(error)
                print(error)
            case .success(let value):
                complition(nil)
                
                var Providers = [SearchModel]()
                
                let json = JSON(value)
                if let data = json["data"].array {
                    for obj in data {
                        if let obj = obj.dictionary {
                            let provider = SearchModel(Data: obj)
                            Providers.append(provider)
                        }
                    }
                }
                
                break
            }
        })
        
    }
    // MARK:- remving all running tasks
    class func removeAllTasks() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach { $0.suspend() }
        }
    }
    
}
