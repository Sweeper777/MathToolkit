import Foundation
import MathParser
import Regexer
import SwiftyUtils

struct OperationInput: Codable {
    let name: String
    let description: String
    let rejectFloatingPoint: Bool
}

struct OperationResult {
    let name: String
    let from: String
    let value: String
}

protocol OperationProtocol {
    var name: String { get }
    var inputs: [OperationInput] { get }
    var image: String? { get }
    var category: String { get }
    
    func calculate (inputs: [String: Double]) -> [OperationResult]?
}

struct OperationImplementation: Codable {
    let resultName: String
    let expression: String
    var fromValues: [String] {
        let captures = (expression as NSString).rx_captures(forGroup: 1, withPattern: "\\$(\\w+)")!
        var variablesUsed = captures.map { ($0 as! RXCapture).text! }
        variablesUsed.remove(objects: "pref90")
        variablesUsed.remove(objects: "pref180")
        variablesUsed.remove(objects: "pi")
        variablesUsed = Array(Set(variablesUsed))
        return variablesUsed
    }
}

struct JsonOperation: Codable, OperationProtocol {
    let name: String
    let inputs: [OperationInput]
    let image: String?
    let category: String
    
    let implementations: [OperationImplementation]
    
    func calculate(inputs: [String : Double]) -> [OperationResult]? {
        var evaluator = Evaluator.shared
        evaluator.angleMeasurementMode = UserSettings.useDegrees ? .degrees : .radians
        let approxEq = Function(name: "approxEq", evaluator: approxEqImpl)
        try! evaluator.registerFunction(approxEq)
        var results = [OperationResult]()
        var substitutions = inputs
        substitutions["pref90"] = UserSettings.pref90Degrees
        substitutions["pref180"] = UserSettings.pref180Degrees
        substitutions["pi"] = UserSettings.valueOfPi
        for impl in implementations {
            if let expression = try? Expression(string: impl.expression), let result = try? evaluator.evaluate(expression, substitutions: substitutions) {
                    if impl.resultName.hasPrefix("'") && impl.resultName.hasSuffix("'") {
                        let value = (result == 1 ? "True" : "False").localized
                        results.append(OperationResult(
                            name: String(impl.resultName.dropFirst().dropLast()),
                            from: fromValues,
                            value: value
                            )
                        )
                    } else {
                        results.append(OperationResult(
                            name: impl.resultName,
                            from: fromValues,
                            value: "\(UserSettings.sigFigOption.correct(result))"
                            )
                        )
                    }
            }
        }
        return results
    }
}
