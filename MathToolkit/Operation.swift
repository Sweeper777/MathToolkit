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
    
    func calculate (inputs: [String: Double]) -> [OperationResult]?
}

struct OperationImplementation: Codable {
    let resultName: String
    let expression: String
}

struct JsonOperation: Codable, OperationProtocol {
    let name: String
    let inputs: [OperationInput]
    let image: String?
    
    let implementations: [OperationImplementation]
    
    func calculate(inputs: [String : Double]) -> [OperationResult]? {
        return nil
    }
}
