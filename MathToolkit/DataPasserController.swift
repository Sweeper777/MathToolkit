import UIKit

class DataPasserController: UINavigationController {
    var operation: OperationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let vc = topViewController as? OperationController {
            vc.operation = operation
        }
    }
}
