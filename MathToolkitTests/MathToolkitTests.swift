import XCTest

class MathToolkitTests: XCTestCase {
    
    lazy var operations: [String: OperationProtocol] = {
        let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "operations", withExtension: "json")!)
        let decoder = JSONDecoder()
        let operationsList = try! decoder.decode([JsonOperation].self, from: jsonData)
        return operationsList.reduce(into: [String: OperationProtocol]()) {
            $0[$1.name] = $1
        }
    }()
    
    override func setUp() {
        super.setUp()
        UserSettings.useDegrees = true
        UserSettings.sigFigOption = .no
        UserSettings.valueOfPiOption = 0
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTrapezium() {
        let operation = operations["Trapezium"]!
        let results = operation.calculate(inputs: ["b1": 1, "b2": 2, "h": 3])
        XCTAssertNotNil(results)
        XCTAssertTrue(results!.contains(OperationResult(name: "Area", from: "", value: "4.5")))
    }
}
