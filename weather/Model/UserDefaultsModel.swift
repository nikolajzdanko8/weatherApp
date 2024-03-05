import Foundation

final class UserDefaultsModel {
    static let shared = UserDefaultsModel()
    let userDefaults = UserDefaults.standard
    private init () {}
    
    func save(dailyModels: [Daily], hourlyModels: [Hourly], currentWeatherModel: Current) {
        saveDailyModels(dailyModels)
        saveHourlyModels(hourlyModels)
        saveCurrentWeatherModelFrom(currentWeatherModel)
    }
    
    private func saveCurrentWeatherModelFrom(_ currentWeather: Current) {
        userDefaults.set(try? PropertyListEncoder().encode(currentWeather), forKey: "currentWeather")
    }
    
    private func saveDailyModels(_ dailyModels: [Daily]) {
        userDefaults.set(try? PropertyListEncoder().encode(dailyModels), forKey: "dailyModels")
    }
    
    //
    private func saveHourlyModels(_ hourlyModels: [Hourly]) {
        userDefaults.set(try? PropertyListEncoder().encode(hourlyModels), forKey: "HourlyModel")
    }
    
    func loadDailyModelsData() -> [Daily] {
        if let data = userDefaults.value(forKey: "dailyWeather") as? Data {
            if let decodedDailyModels = try? PropertyListDecoder().decode([Daily].self, from: data) {
                return decodedDailyModels
            }
        }
        return [Daily]()
    }
    
    func loadHourlyModelsData() -> [Hourly] {
        if let data = userDefaults.value(forKey: "hourlyWeatherModel") as? Data {
            if let decodedHourlyModels = try? PropertyListDecoder().decode([Hourly].self, from: data) {
                return decodedHourlyModels
            }
        }
        return [Hourly]()
    }
    
    func loadHCurrentWeatherModelData() -> Current? {
        if let data = userDefaults.value(forKey: "Current") as? Data {
            if let decodedCurrentWeatherModel = try? PropertyListDecoder().decode(Current.self, from: data) {
                return decodedCurrentWeatherModel
            }
        }
        return nil
    }
    
}
