import Foundation

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
        let matches = "\\$(\\w)".r!.findAll(in: expression)
        var variablesUsed = matches.map { $0.group(at: 1)! }
        variablesUsed.remove(objects: "pref90")
        variablesUsed.remove(objects: "pref180")
        variablesUsed.remove(objects: "pi")
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
        evaluator.angleMeasurementMode = UserDefaults.standard.bool(forKey: "useDegrees") ? .degrees : .radians
        var results = [OperationResult]()
        var substitutions = inputs
        substitutions["pref90"] = UserSettings.pref90Degrees
        substitutions["pref180"] = UserSettings.pref180Degrees
        substitutions["pi"] = UserSettings.valueOfPi
        for impl in implementations {
            if let expression = try? Expression(string: impl.expression), let result = try? evaluator.evaluate(expression, substitutions: substitutions) {
                let fromValues = String(format: "From %@".localized, impl.fromValues.joined(separator: ", "))
                results.append(OperationResult(
                    name: impl.resultName,
                    from: fromValues,
                    value: "\(UserSettings.sigFigOption.correct(result))"
                    )
                )
            }
        }
        return results
    }
}
