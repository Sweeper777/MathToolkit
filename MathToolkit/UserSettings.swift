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
    
    enum SigFigOptions{
        case no
        case yes(Int)
        
        func correct (_ i: Double) -> Double {
            switch self {
            case .no:
                return i
            case let .yes(sigFig):
                if i == 0 {
                    return 0
                }
                let d = ceil(log10(i < 0 ? -i : i))
                let power = sigFig - Int(d)
                let magnitude = pow(10.0, Double(power))
                let shifted = round(i * magnitude)
                return shifted / magnitude
            }
        }
    }
    
    static var sigFigOption: SigFigOptions {
        get {
            let storedValue = UserDefaults.standard.integer(forKey: "sigFigOption")
            return storedValue == 0 ? .no : .yes(storedValue)
        }
        
        set {
            switch newValue {
            case .no:
                UserDefaults.standard.set(0, forKey: "sigFigOption")
            case .yes(let x):
                UserDefaults.standard.set(x, forKey: "sigFigOption")
            }
        }
    }
    
    static var useDegrees: Bool {
        get { return UserDefaults.standard.bool(forKey: "useDegrees") }
        set { UserDefaults.standard.set(newValue, forKey: "useDegrees") }
    }
    
    static func convertToPref (_ angleRadians: Double) -> Double {
        return useDegrees ? 180 * angleRadians / UserSettings.valueOfPi : angleRadians
    }
    
    static func convertFromPref (_ prefAngle: Double) -> Double {
        return useDegrees ? prefAngle * UserSettings.valueOfPi / 180.0 : prefAngle
    }
    
    static var pref90Degrees: Double {
        return convertToPref(valueOfPi / 2)
    }
    
    static var pref180Degrees: Double {
        return pref90Degrees * 2
    }
    
    static var aValue: Double {
        get { return UserDefaults.standard.double(forKey: "aValue") }
        set { UserDefaults.standard.set(newValue, forKey: "aValue") }
    }
    
    static var bValue: Double {
        get { return UserDefaults.standard.double(forKey: "bValue") }
        set { UserDefaults.standard.set(newValue, forKey: "bValue") }
    }
    
    static var cValue: Double {
        get { return UserDefaults.standard.double(forKey: "cValue") }
        set { UserDefaults.standard.set(newValue, forKey: "cValue") }
    }
}

