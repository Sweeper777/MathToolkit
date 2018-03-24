import UIKit
import MGSwipeTableCell

class ResultController: UITableViewController {
    var results: [[OperationResult]]!
    
    override func viewDidLoad() {
        title = "Results".localized
    }
}
