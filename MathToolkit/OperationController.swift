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
        
        form +++ ButtonRow() {
            row in
            row.title = "Clear All Inputs".localized
        }.onCellSelection({ [unowned self] (cell, row) in
            self.form.allRows.forEach {
                $0.baseValue = nil
                $0.updateCell()
            }
        })
            .cellUpdate({ (cell, row) in
            cell.textLabel?.textColor = UIColor(hex: "3b7b3b")
        })
        
        let section = Section("inputs".localized)
        
        for input in operation.inputs {
            section <<< TextRow(input.name) {
                row in
                row.cell.textField.placeholder = "Enter a value...".localized
                row.title = "\(input.name) = "
                row.cell.titleLabel?.font = UIFont(name: "Times New Roman", size: UIFont.systemFontSize)
            }
            .cellUpdate({ (cell, row) in
                row.cell.textField.textAlignment = NSTextAlignment.left
                row.cell.textField.keyboardType = .numbersAndPunctuation
            })
        }
        
        form +++ section
    }
}
