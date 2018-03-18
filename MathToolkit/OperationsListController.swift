import UIKit
import EZLoadingActivity

class OperationsListController: UITableViewController {

    var operations: [[OperationProtocol]] = []
    
    func loadOperations(completion: @escaping () -> Void) {
        {
            [weak self] in
            let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "operations", withExtension: "json")!)
            let decoder = JSONDecoder()
            let operationsList = try! decoder.decode([JsonOperation].self, from: jsonData)
            self?.operations = operationsList.groupBy { $0.category }
        } ~> completion
    }
    
}

