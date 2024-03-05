import Foundation

extension Int {
    func addDailyDate(date: Int, dateFormat: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let hourDate = formatter.string(from: date).capitalized
        return hourDate
    }
}
