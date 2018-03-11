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

