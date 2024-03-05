import Foundation
import UIKit

class CustomStruct {
    var lat: Double?
    var lon: Double?
    var image: UIImage?
    var textTemp: String?
    var textName: String?
    var dt: Int?
    
    init(lat: Double?, lon: Double?, image: UIImage?, textTemp: String?, textName: String?, dt: Int? ) {
        self.lat = lat
        self.lon = lon
        self.image = image
        self.textTemp = textTemp
        self.textName = textName
        self.dt = dt
    }
}
