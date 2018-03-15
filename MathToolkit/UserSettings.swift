import Foundation

class UserSettings {
    static var valueOfPi: Double {
        get {
            if UserDefaults.standard.double(forKey: "valueOfPi") == 0 {
                UserDefaults.standard.set(Double.pi, forKey: "valueOfPi")
                return Double.pi
            } else {
                return UserDefaults.standard.double(forKey: "valueOfPi")
            }
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "valueOfPi")
        }
    }
}
