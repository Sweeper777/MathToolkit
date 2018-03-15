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
    var description: String { get }
    
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
    let description: String
    
    let implementations: [OperationImplementation]
    
    func calculate(inputs: [String : Double]) -> [OperationResult]? {
        return nil
    }
}
