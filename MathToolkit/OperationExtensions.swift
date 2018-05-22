import Foundation

typealias OperationExtension = ([String : Double]) -> [OperationResult]

class OperationExtensions {
    private init() {}
    
    static let allExtensions: [String: OperationExtension] = [
        "Triangle": triangle,
        "Prime Number": primeNumber,
        "Prime Factors": primeFactors,
        "Factors": factors,
        "Factor Pairs": factorPairs,
    ]
    
    private static func triangle(inputs: [String: Double]) -> [OperationResult] {
        func equalDouble(_ a: Double, _ b: Double) -> Bool {
            return abs(a - b) < 1e-14
        }
        
        var results = [OperationResult]()
        if let s1 = inputs["s1"], let s2 = inputs["s2"], let s3 = inputs["s3"] {
            let a2 = s1 * s1
            let b2 = s2 * s2
            let c2 = s3 * s3
            if equalDouble(a2, b2 + c2) || equalDouble(b2, c2 + a2) || equalDouble(c2, a2 + b2) {
                results.append(OperationResult(name: "Right Angled", from: "s1, s2, s3", value: "True"))
            } else {
                results.append(OperationResult(name: "Right Angled", from: "s1, s2, s3", value: "False"))
            }
        }
        return results
    }
    
    private static func isPrime(_ number: Int) -> Bool {
        return number > 1 && !(2..<number).contains { number % $0 == 0 }
    }
    
    private static func primeNumber(inputs: [String: Double]) -> [OperationResult] {
        var results = [OperationResult]()
        if let x = inputs["x"] {
            results.append(OperationResult(name: "Is Prime?", from: "x", value: isPrime(Int(x)) ? "True" : "False"))
        }
        return results
    }
    
    private static func primeFactors(inputs: [String: Double]) -> [OperationResult] {
        var results = [OperationResult]()
        
        if let x = inputs["x"] {
            var intX = Int(x)
            let largestPrimeFactor = intX / 2
            if largestPrimeFactor > 0 {
                var primeFactors: [Int] = []
                for i in 2...largestPrimeFactor {
                    if isPrime(i) && intX % i == 0 {
                        results.append(OperationResult(name: "Prime Factors", from: "x", value: "\(i)"))
                        primeFactors.append(i)
                    }
                }
                
                var primeFactorProduct: [Int] = []
                
                for factor in primeFactors {
                    while true {
                        if intX % factor == 0 {
                            intX /= factor
                            primeFactorProduct.append(factor)
                            continue
                        } else {
                            break
                        }
                    }
                }
                
                var primeFactorProductResult = ""
                
                for i in 0..<primeFactorProduct.count {
                    let factor = primeFactorProduct[i]
                    if i == primeFactorProduct.count - 1 {
                        primeFactorProductResult += "\(factor)"
                    } else {
                        primeFactorProductResult += "\(factor) × "
                    }
                }
                results.append(OperationResult(name: "Multiplication of Prime Factors", from: "x", value: primeFactorProductResult))
            }
        }
        return results
    }
    
    private static func getFactors(of x: Int) -> [Int] {
        let largestFactor = x / 2
        var arr: [Int] = []
        
        if largestFactor < 0 {
            for i in 1...(-largestFactor) {
                if x % i == 0 {
                    arr.append(-i)
                }
            }
            return arr
        }
        
        if largestFactor == 0 {
            return []
        }
        
        for i in 1...largestFactor {
            if x % i == 0 {
                arr.append(i)
            }
        }
        
        if x != 1 {
            arr.append((x))
        }
        return arr
    }
    
    private static func gcd(x: Int, y: Int) -> Int {
        guard y != 0 else { return x }
        return gcd(x: y, y: x % y)
    }
    
    private static func factors(inputs: [String: Double]) -> [OperationResult] {
        var results = [OperationResult]()
        if let x = inputs["x"] {
            let factors = getFactors(of: Int(x))
            for factor in factors {
                results.append(OperationResult(name: "Factors", from: "x", value: "\(factor)"))
            }
        }
        
        if let y = inputs["y"] {
            let factors = getFactors(of: Int(y))
            for factor in factors {
                results.append(OperationResult(name: "Factors", from: "y", value: "\(factor)"))
            }
        }
        
        if let x = inputs["x"], let y = inputs["y"] {
            let greatestCommonFactor = gcd(x: abs(Int(x)), y: abs(Int(y)))
            results.append(OperationResult(name: "Greatest Common Factor", from: "x, y", value: "\(greatestCommonFactor)"))
        }
        
        return results
    }
    
    private static func factorPairs(inputs: [String: Double]) -> [OperationResult] {
        var results = [OperationResult]()
        if let x = inputs["x"] {
            let factors = getFactors(of: Int(x))
            
            for factor in factors {
                results.append(OperationResult(name: "Factor Pairs", from: "x", value: "\(factor) × \(Int(x) / factor)"))
            }
        }
        return results
    }
}
