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
    
}
