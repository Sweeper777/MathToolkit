import UIKit
import Eureka
import ViewRow
import RFKeyboardToolbar

class OperationController: FormViewController {
    var operation: OperationProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let op = operation else {
            return
        }
        self.title = op.name.localized
        
        let section = Section("inputs".localized)
        
        for input in operation.inputs {
            section <<< TextRow(input.name) {
                row in
                row.cell.textField.placeholder = "Enter a value...".localized
                row.title = "\(input.name) = "
                row.cell.titleLabel?.font = UIFont(name: "Times New Roman", size: UIFont.systemFontSize)
            }
        }
        
        form +++ section
    }
}
