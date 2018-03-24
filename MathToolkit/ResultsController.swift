import UIKit
import MGSwipeTableCell

class ResultController: UITableViewController {
    var results: [[OperationResult]]!
    
    override func viewDidLoad() {
        title = "Results".localized
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return results?.count ?? 1
    }
    
}
