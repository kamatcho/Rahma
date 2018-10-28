import Foundation
import CoreLocation
import MapKit
import SwiftyJSON
import UIKit

class APIUser {
    
    static var main : APIUser! = APIUser()
    
    var id     : String!
    var kind   : String!
    var name   : String!
    var mail   : String!
    var mobile : String!
    var image  : String!
    var status : String!
    var country : String!
    var available_status : String!
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.kind = json["kind"].stringValue
        self.name = json["name"].stringValue
        self.mail = json["mail"].stringValue
        self.mobile = json["mobile"].stringValue
        self.image = json["image"].stringValue
        self.status = json["working"].stringValue
        self.country = json["country"].stringValue
        self.available_status = json["available_status"].stringValue
    }
    
    static func parseUsers(json: JSON) -> [APIUser] {
        var users = [APIUser]()
        for user in json.arrayValue {
            users.append(APIUser(json: user))
        }
        return users
    }
    
    private init() {
        if APIUser.isUserAvailabelOnDefaults {
            self.loadUserFromDefaults()
        }
    }
    
    static var isUserAvailabelOnDefaults : Bool {
        return UserDefaults.standard.string(forKey: "id") != nil
    }
    
    func saveUserToDefaults() {
        UserDefaults.standard.set(self.id, forKey: "id")
        UserDefaults.standard.set(self.kind, forKey: "kind")
        UserDefaults.standard.set(self.name, forKey: "name")
        UserDefaults.standard.set(self.mobile, forKey: "mobile")
        UserDefaults.standard.set(self.mail, forKey: "mail")
        UserDefaults.standard.set(self.image, forKey: "image")
        UserDefaults.standard.set(self.status, forKey: "working")
        UserDefaults.standard.set(self.country, forKey: "country")
        UserDefaults.standard.set(self.available_status, forKey: "available_status")
        UserDefaults.standard.synchronize()
        APIUser.main.loadUserFromDefaults()
    }
    
    private func loadUserFromDefaults() {
        self.id = UserDefaults.standard.string(forKey: "id")
        self.kind = UserDefaults.standard.string(forKey: "kind")
        self.name = UserDefaults.standard.string(forKey: "name")
        self.mobile = UserDefaults.standard.string(forKey: "mobile")
        self.mail = UserDefaults.standard.string(forKey: "mail")
        self.image = UserDefaults.standard.string(forKey: "image")
        self.status = UserDefaults.standard.string(forKey: "working")
        self.country = UserDefaults.standard.string(forKey: "country")
        self.available_status = UserDefaults.standard.string(forKey: "available_status")
        UserDefaults.standard.synchronize()
    }
    
    static func removeUserFromDefaults() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "kind")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "mobile")
        UserDefaults.standard.removeObject(forKey: "mail")
        UserDefaults.standard.removeObject(forKey: "image")
        UserDefaults.standard.removeObject(forKey: "working")
        UserDefaults.standard.removeObject(forKey: "country")
        UserDefaults.standard.removeObject(forKey: "available_status")
        UserDefaults.standard.synchronize()
    }
    
}

struct APIStatus {
    var isSuccess : Bool
    var message : String
    
    init(isSuccess: Bool, message: String = "") {
        self.isSuccess = isSuccess
        self.message = message
    }
    
    init(json: JSON) {
        self.isSuccess = json["type"].stringValue == "success"
        self.message = json["title"].stringValue
    }
}

struct APIResponse {
    var status : APIStatus!
    var result : JSON!
    
    init(json: JSON) {
        self.result = json["data"]
        self.status = APIStatus(json: json["status"])
    }
}

class EkeifVideo : Equatable {
    var id : String
    var title : String
    var created : String
    var description : String
    var youtubeID : String
    var isLiked : Bool
    var isWatched : Bool
    var numberOfLikes : String
    var numberOfComments : String
    var numberOfViews : String
    
    var date : String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ar")
        return dateFormatter.string(from: Date(timeIntervalSince1970: Double(self.created)!))
    }
    
    var thumbnail : URL! {
        return URL(string: "https://i.ytimg.com/vi/\(self.youtubeID)/mqdefault.jpg")!
    }
        
    var user : APIUser
    
    init(json: JSON) {
        self.id = json["vid"].stringValue
        self.title = json["title"].stringValue
        self.created = json["created"].stringValue
        self.description = json["description"].stringValue
        self.youtubeID = json["youtube_id"].stringValue
        self.isLiked = json["is_liked"].stringValue == "1"
        self.isWatched = json["is_watched"].stringValue == "1"
        self.numberOfLikes = json["number_of_likes"].stringValue
        self.numberOfComments = json["number_of_comments"].stringValue
        self.numberOfViews = json["number_of_views"].stringValue
        self.user = APIUser(json: json["user"])
    }
    
    static func parseVideos(json: JSON) -> [EkeifVideo] {
        var videos = [EkeifVideo]()
        for video in json.arrayValue {
            videos.append(EkeifVideo(json: video))
        }
        return videos
    }
    
    public static func ==(lhs: EkeifVideo, rhs: EkeifVideo) -> Bool {
        return lhs.id == rhs.id
    }
}

class APIEnquiry : Equatable {
    var id : String
    var title : String
    var body : String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.body = json["body"].stringValue
        
    }
    
    static func parseEnquiries(json: JSON) -> [APIEnquiry] {
        var enquiries = [APIEnquiry]()
        for enquiry in json.arrayValue {
            enquiries.append(APIEnquiry(json: enquiry))
        }
        return enquiries
    }
    
    public static func ==(lhs: APIEnquiry, rhs: APIEnquiry) -> Bool {
        return lhs.id == rhs.id
    }
}

class APIHospital : Equatable {
    var id : String
    var name : String
    var mobile : String
    var mail : String
    var city: String
    var country : String
    var address : String
    var website : String
    var centerType : String
    var image: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.mobile = json["mobile"].stringValue
        self.mail = json["mail"].stringValue
        self.city = json["city"].stringValue
        self.country = json["country"].stringValue
        self.address = json["address"].stringValue
        self.website = json["website"].stringValue
        self.centerType = json["centerType"].stringValue
        self.image = json["image"].stringValue
    }
    
    static func parseHospitals(json: JSON) -> [APIHospital] {
        var hospitals = [APIHospital]()
        for hospital in json.arrayValue {
            hospitals.append(APIHospital(json: hospital))
        }
        return hospitals
    }
    
    public static func ==(lhs: APIHospital, rhs: APIHospital) -> Bool {
        return lhs.id == rhs.id
    }
    
}

enum APIDeviceType: Int {
    case donation, sale, rent
}

class APIDevice : Equatable {
    var id : String
    var description : String
    var price : String
    var image : String
    
    var user: APIUser!
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.description = json["description"].stringValue
        self.price = json["price"].stringValue
        self.image = json["image"].stringValue
        self.user = APIUser(json: json["user"])
    }
    
    static func parseDevices(json: JSON) -> [APIDevice] {
        var devices = [APIDevice]()
        for device in json.arrayValue {
            devices.append(APIDevice(json: device))
        }
        return devices
    }
    
    public static func ==(lhs: APIDevice, rhs: APIDevice) -> Bool {
        return lhs.id == rhs.id
    }
}

class APIExperience : Equatable {
    var id : String
    var title : String
    var doctor : String
    var hospital : String
    var country : String
    var body : String
    var time : String
    
    var date : String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale.init(identifier: "ar")
        return dateFormatter.string(from: Date(timeIntervalSince1970: Double(self.time)!))
    }
    
    var user: APIUser!
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.doctor = json["doctor"].stringValue
        self.hospital = json["hospital"].stringValue
        self.country = json["country"].stringValue
        self.body = json["body"].stringValue
        self.time = json["date"].stringValue
        self.user = APIUser(json: json["user"])
    }
    
    static func parseExperiences(json: JSON) -> [APIExperience] {
        var devices = [APIExperience]()
        for device in json.arrayValue {
            devices.append(APIExperience(json: device))
        }
        return devices
    }
    
    public static func ==(lhs: APIExperience, rhs: APIExperience) -> Bool {
        return lhs.id == rhs.id
    }
}


class APIRequest : Equatable {
    var id : String
    var name : String
    var mobile : String
    var mail : String
    var address : String
    var country : String
    var website : String
    var centerType : String
    var image: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.mobile = json["mobile"].stringValue
        self.mail = json["mail"].stringValue
        self.address = json["address"].stringValue
        self.country = json["country"].stringValue
        self.website = json["website"].stringValue
        self.centerType = json["centerType"].stringValue
        self.image = json["image"].stringValue
    }
    
    static func parseRequests(json: JSON) -> [APIRequest] {
        var requests = [APIRequest]()
        for request in json.arrayValue {
            requests.append(APIRequest(json: request))
        }
        return requests
    }
    
    public static func ==(lhs: APIRequest, rhs: APIRequest) -> Bool {
        return lhs.id == rhs.id
    }
}






