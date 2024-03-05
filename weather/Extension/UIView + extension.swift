import Foundation
import UIKit

extension UIView {
    
    func cloudsWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.971, green: 0.986, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.679, green: 0.846, blue: 1, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func clearWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.583, green: 0.8, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.872, green: 0.938, blue: 1, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func rainWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.934, green: 0.947, blue: 0.958, alpha: 1).cgColor,
            UIColor(red: 0.762, green: 0.825, blue: 0.883, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
        
    }
    
    func thunderstormWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.768, green: 0.765, blue: 0.892, alpha: 1).cgColor,
            UIColor(red: 0.938, green: 0.97, blue: 1, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func mainlyСloudyWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.917, green: 0.96, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.854, green: 0.832, blue: 0.79, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func mistWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.773, green: 0.822, blue: 0.867, alpha: 1).cgColor,
            UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func snowWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.788, green: 0.87, blue: 0.946, alpha: 1).cgColor,
            UIColor(red: 0.71, green: 0.759, blue: 0.804, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func sunnyWeatherGradient(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [
            UIColor(red: 0.7, green: 0.856, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.852, green: 0.883, blue: 0.913, alpha: 1).cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        layer.bounds = view.bounds.insetBy(dx: -1 * view.bounds.size.width, dy: -1 * view.bounds.size.height)
        layer.position = view.center
        self.layer.insertSublayer(layer, at: 0)   
    }
}
