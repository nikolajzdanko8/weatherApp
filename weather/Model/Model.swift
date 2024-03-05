import Foundation

struct Model: Codable {
    var lat: Double?
    var lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
}

struct Current: Codable {
    var windSpeed: Double?
    var clouds: Int?
    var visibility: Int?
    var humidity: Int?
    var feelsLike: Double?
    var pressure: Int?
    var uvi: Double?
    var dt: Int?
    var sunrise: Int?
    var sunset: Int?
    var rain: RainCurrent?
    var snow: SnowCurrent?
    var temp: Double?
    var weather: [CurrentWeather]
}

struct CurrentWeather: Codable {
    var main: String?
    var icon: String?
    var description: String?
}

struct SnowCurrent: Codable {
    var oneHh: Double?
   private enum CodingKeys: String, CodingKey {
        case oneHh = "1h"
    }
}

struct RainCurrent: Codable {
    var oneHh: Double?
    private enum CodingKeys: String, CodingKey {
        case oneHh = "1h"
    }
}

struct Hourly: Codable {
    var dt: Int?
    var pop: Double?
    var rain: RainHourly?
    var snow: SnowHourly?
    var temp: Double?
    var weather: [HourlyIcon]
}

struct HourlyIcon: Codable {
    var icon: String?
}

struct SnowHourly: Codable {
    var oneHh: Double?
   private enum CodingKeys: String, CodingKey {
        case oneHh = "1h"
    }
}

struct RainHourly: Codable {
    var oneHh: Double?
    private enum CodingKeys: String, CodingKey {
        case oneHh = "1h"
    }
}

struct Daily: Codable {
    var dt: Int?
    var pop: Double?
    var rain: Double?
    var snow: Double?
    var temp: Temp?
    var weather: [DailyIcon]
}

struct Temp: Codable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
}

struct DailyIcon: Codable {
    var icon: String?
}
