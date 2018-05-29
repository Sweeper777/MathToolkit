import XCTest
@testable import MathToolkit

class MathToolkitTests: XCTestCase {
    
    func testOperationResult() {
        let operationResult = OperationResult(name: "My Result", from: "a, b", value: "100")
        XCTAssertEqual(operationResult.name, "My Result")
        XCTAssertEqual(operationResult.from, "a, b")
        XCTAssertEqual(operationResult.value, "100")
    }
    
}
