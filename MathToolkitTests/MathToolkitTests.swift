import XCTest
@testable import MathToolkit

class MathToolkitTests: XCTestCase {
    
    func testOperationResult() {
        let operationResult = OperationResult(name: "My Result", from: "a, b", value: "100")
        XCTAssertEqual(operationResult.name, "My Result")
        XCTAssertEqual(operationResult.from, "a, b")
        XCTAssertEqual(operationResult.value, "100")
    }
    
    func testOperationImplementationSingleInput() {
        let implementation = OperationImplementation(resultName: "Area", expression: "$r * $r * $pi")
        XCTAssertEqual(implementation.expression, "$r * $r * $pi")
        XCTAssertEqual(implementation.resultName, "Area")
        XCTAssertEqual(implementation.fromValues, ["r"])
    }
    
    func testOperationImplementationMultipleInputs() {
        let implementation = OperationImplementation(resultName: "Area", expression: "$r * $r * $pi * $h")
        XCTAssertEqual(implementation.fromValues, ["r", "h"])
    }
}
