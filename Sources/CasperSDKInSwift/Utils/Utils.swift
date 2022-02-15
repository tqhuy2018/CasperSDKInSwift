import Foundation
let secondInMillisecond:UInt64 = UInt64(1000)
let miniuteInMilisecond:UInt64 = UInt64(60 * 1000)
let hourInMilisecond:UInt64 = UInt64(3600 * 1000)
let dayInMilisecond:UInt64 = hourInMilisecond * 24
let weekInMilisecond:UInt64 = dayInMilisecond * 7
let monthInMilisecond:UInt64 = dayInMilisecond * 30
let yearInMilisecond:UInt64 = dayInMilisecond * 365
class Utils {
    public static func miliSecondToTTL(m:UInt64)->String {
        if m > yearInMilisecond {
            let totalYear = m/yearInMilisecond
            return "\(totalYear)year"
        } else if m > monthInMilisecond {
            let totalMonth = m/monthInMilisecond
            return "\(totalMonth)month"
        } else if m>weekInMilisecond {
            let totalWeek = m/weekInMilisecond
            return "\(totalWeek)week"
        } else if m>dayInMilisecond {
            let totalDay = m/dayInMilisecond
            return "\(totalDay)day"
        } else if m>hourInMilisecond {
            let totalHour = m/hourInMilisecond
            return "\(totalHour)h"
        } else if m>miniuteInMilisecond {
            let totalMinute = m/miniuteInMilisecond
            return "\(miniuteInMilisecond)m"
        } else if m>secondInMillisecond {
            let totalSecond = m/secondInMillisecond
            return "\(totalSecond)s"
        } else {
            return ""
        }
    }
    public static func ttlToMilisecond(ttl:String)->UInt64 {
        if ttl.contains("day") {
            let index = ttl.index(ttl.endIndex,offsetBy: -3)
            let day64 = UInt64(String(ttl[..<index]))! * 24 * 3600 * 1000
            return day64
        } else if ttl.contains("m") {
            let index = ttl.index(ttl.endIndex,offsetBy:-1)
            let m64 = UInt64(String(ttl[..<index]))! * 60 * 1000
            return m64
        } else if ttl.contains("h") {
            let index = ttl.index(ttl.endIndex,offsetBy: -1)
            let h64 = UInt64(String(ttl[..<index]))! * 3600 * 1000
            return h64
        }
        return 1
    }
    public static func dateStrToMilisecond(dateStr: String) -> UInt64 {
        let elements = dateStr.components(separatedBy: ".")
        let realStr = elements[0] + "Z"
        let remainMiliStr = elements[1]
        let index = remainMiliStr.index(remainMiliStr.startIndex,offsetBy: 3)
        let milisecondStr = String(remainMiliStr[..<index])
        let milisecondU64:UInt64 = UInt64(milisecondStr)!
    
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:realStr)!
        let ret :UInt64 = UInt64(date.millisecondsSince1970) + milisecondU64
        return ret;
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}
