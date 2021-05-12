import Foundation

extension Date {

    func defaultFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: self)
    }
}

extension String {

    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.date(from: self)
    }
}
