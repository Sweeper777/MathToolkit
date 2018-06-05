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
    
    func testTriangleExtensions() {
        let triangleExtension = OperationExtensions.allExtensions["Triangle"]
        XCTAssertNotNil(triangleExtension)
        let noResult = triangleExtension!([:])
        XCTAssertTrue(noResult.isEmpty)
        let trueResult = triangleExtension!(["a": 3, "b": 4, "c": 5])
        XCTAssertTrue(trueResult.count == 1)
        XCTAssertEqual(trueResult[0].value, "True")
        let falseResult = triangleExtension!(["a": 1, "b": 1, "c": 1])
        XCTAssertTrue(falseResult.count == 1)
        XCTAssertEqual(falseResult[0].value, "False")
    }
}
