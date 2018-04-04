import Foundation

typealias OperationExtension = ([String : Double]) -> [OperationResult]

class OperationExtensions {
    private init() {}
    
    static let allExtensions: [String: OperationExtension] = [
        "Triangle": triangle
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
}
