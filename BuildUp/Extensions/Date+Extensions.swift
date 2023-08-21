//
//  Date+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import Foundation

extension Date {
    
    func getFullDate(monthTemplate: String = "MM", seperator: String = "/") -> String {
        let day = self.getDay()
        let month = self.getMonth(template: monthTemplate)
        let year = self.getYear()
        
        return "\(day)\(seperator)\(month)\(seperator)\(year)"
    }
    
    func getDayAndMonth(monthTemplate: String = "MMMM", seperator: String = " ") -> String {
        let day = self.getDay()
        let month = self.getMonth(template: monthTemplate)
        
        return "\(day)\(seperator)\(month)\(seperator)"
    }
    
    func getHijriDate() {
        let hijriCalendar = Calendar(identifier: .islamicCivil)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar")
        formatter.calendar = hijriCalendar
        formatter.dateFormat = "dd/MM/yyyy"

        print(formatter.string(from: Date()))
    }
    
    func getDay() -> String {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) ?? TimeZone.current
        
        var day = dateFormatter.string(from: self)
        print(day)
        print(self)

        if day.first == "0" {
            day.removeFirst()
        }
        
        return day
    }
    
    func getMonth(template: String = "MMM") -> String {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
        dateFormatter.setLocalizedDateFormatFromTemplate(template)
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) ?? TimeZone.current
        
        let fullDate = dateFormatter.string(from: self)
        
        return fullDate
    }
    
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
       
        let fullDate = dateFormatter.string(from: self)
        
        return fullDate
    }
    
    func getDayName(languageCode: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: languageCode ?? LocalizationManager.currentLanguage().appLanguageCode)
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
       
        let fullDate = dateFormatter.string(from: self)
        
        return fullDate
    }
    
    func getTime12() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
        dateFormatter.setLocalizedDateFormatFromTemplate("hh a")
        
        if LocalizationManager.currentLanguage().appLanguageCode == Language.arabic.rawValue {
            dateFormatter.pmSymbol = "م"
            dateFormatter.amSymbol = "ص"
        } else {
            dateFormatter.pmSymbol = "pm"
            dateFormatter.amSymbol = "am"
        }
        
        let timeDate = dateFormatter.string(from: self)
        
        return timeDate
    }
    
    func getDateAndTime() -> String {
        
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        print(localTimeZoneAbbreviation)
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM yy, hh:mm a")
//        dateFormatter.pmSymbol = L10n.Orders.pmSymbol
//        dateFormatter.amSymbol = L10n.Orders.amSymbol
        dateFormatter.locale = Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
        let dateString = dateFormatter.string(from: self)
        
        return dateString
//        if time.contains(",") {
//            
//            if let timeString = time.split(separator: ",").last {
//                return String(timeString)
//            }
//        } else if time.contains("،") {
//            if let timeString = time.split(separator: "،").last {
//                return String(timeString)
//            }
//        }
//        
//        return ""
    }
    
        func getTime() -> String {
            
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
            print(localTimeZoneAbbreviation)
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm a")
            dateFormatter.locale = Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
            let time = dateFormatter.string(from: self)
            
//            if time.contains(",") {
//
//                if let timeString = time.split(separator: ",").last {
//                    return String(timeString)
//                }
//            } else if time.contains("،") {
//                if let timeString = time.split(separator: "،").last {
//                    return String(timeString)
//                }
//            }
            
            return time
        }
    
    func getTime24() -> String {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) ?? TimeZone.current
                
        let currentHour = calendar.component(.hour, from: self)
        let currentMinutes = calendar.component(.minute, from: self)
        
        if currentMinutes < 10 {
            return "\(currentHour):0\(currentMinutes)"
        } else {
            return "\(currentHour): \(currentMinutes)"
        }
    }
    
    func getDayOfWeek(_ todayDate: Date) -> Int? {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return (weekDay - 1)
    }
}

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else { return Date() }
        
        return localDate
    }
}

extension DateFormatter {
    class var serverFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
//        print(getCurrentDateWith(timezoneOffset: TimeZone.current.secondsFromGMT()))
    }
    
    func getCurrentDateWith(timezoneOffset: Int ) -> Date {
        let epochDate = Date().timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        let timeZoneOffsetDate = Date(timeIntervalSince1970: timezoneEpochOffset)
        return timeZoneOffsetDate
    }
    
    func getDateWith(timezoneOffset: Int ) -> Date {
        let epochDate = self.timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        let timeZoneOffsetDate = Date(timeIntervalSince1970: timezoneEpochOffset)
        return timeZoneOffsetDate
    }
    
    func isToday() -> Bool {
        
        if let diff = Calendar.current.dateComponents([.hour, .minute], from: self, to: Date()).hour, diff >= 24 {
            return false
        } else {
            return true
        }
    }
    
    func isLessMinute() -> Bool {
        
        if let diff = Calendar.current.dateComponents([.minute, .second], from: self, to: Date()).minute, diff < 1 {
            return true
        } else {
            return false
        }
    }
    
    func getFormattedDate(higriDate: String? = nil) -> String {
        if isToday() {
            if isLessMinute() {
                return "justNow"
            } else {
                if LocalizationManager.currentLanguage().appLanguageCode == Language.arabic.rawValue {
                    let date = timeAgoDisplay()
                    return date.replacingOccurrences(of: "قبل", with: "منذ")
//                    return date.replacingOccurrences(of: "واحدة", with: "")
                } else {
                    return timeAgoDisplay()
                }
            }
        } else {
            return "\(getDayName()) \(rearrangeHijriDateinRTL(higriDate: higriDate ?? ""))"
        }
    }
    
    func rearrangeHijriDateinRTL(higriDate: String) -> String {
        var items: [String] = []
        let hiriItems = higriDate.split(separator: "-")
        items = hiriItems.map { subSTring in
            return String(subSTring)
        }
        
        items.reverse()
        
        return items.joined(separator: "-")
    }
    
    func getDayAndHijri(higriDate: String, languageCode: String? = nil) -> String {
        return "\(getDayName(languageCode: languageCode)) \(higriDate)"
    }
    
    func isAfter(oldDate: Date) -> Bool {
        
         let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: oldDate, to: self)
        
        if (diff.year ?? 0) >= 0 &&
            (diff.month ?? 0) >= 0  &&
            (diff.day ?? 0) >= 0 &&
            (diff.hour ?? 0) >= 0 &&
            (diff.minute ?? 0) >= 0 {
            return true
        } else {
            return false
        }
    }
}
