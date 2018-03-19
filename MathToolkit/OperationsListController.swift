import UIKit
import EZLoadingActivity

class OperationsListController: UITableViewController {

    var operations: [[OperationProtocol]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if operations.isEmpty {
            EZLoadingActivity.show("Loading...".localized, disableUI: true)
            loadOperations {
                [weak self] in
                self?.tableView.reloadData()
                EZLoadingActivity.hide()
            }
        }
    func loadOperations(completion: @escaping () -> Void) {
        {
            [weak self] in
            let jsonData = try! Data(contentsOf: Bundle.main.url(forResource: "operations", withExtension: "json")!)
            let decoder = JSONDecoder()
            let operationsList = try! decoder.decode([JsonOperation].self, from: jsonData)
            self?.operations = operationsList.groupBy { $0.category }
        } ~> completion
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return operations.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations[section].count
    }
    
}

