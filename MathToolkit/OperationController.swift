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
        
        if let imageName = operation.image {
            form +++ ViewRow<UIImageView>() {
                row in
            }.cellSetup({ (cell, row) in
                let imageView = UIImageView(image: UIImage(named: imageName))
                imageView.contentMode = .scaleAspectFit
                imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
                cell.view = imageView
            })
        }
        
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
                let toolbar = RFKeyboardToolbar(buttons: [])
                toolbar?.addKey("+", to: row)
                toolbar?.addKey("-", to: row)
                toolbar?.addKey("*", to: row)
                toolbar?.addKey("/", to: row)
                toolbar?.addKey("(", to: row)
                toolbar?.addKey(")", to: row)
                toolbar?.addKey("$", to: row)
                row.cell.textField.inputAccessoryView = toolbar
            }
            .cellUpdate({ (cell, row) in
                row.cell.textField.textAlignment = NSTextAlignment.left
                row.cell.textField.keyboardType = .numbersAndPunctuation
            })
        }
        
        form +++ section
    }
    
    @IBAction func calculate() {
        
    func processInputs() -> [String: Double]? {
        let values = form.values()
        var inputValues = [String: Double]()
        for input in operation.inputs {
            if let expr = values[input.name] as? String {
                if expr.trimmed() != "" {
                }
            }
        }
        return inputValues
    }
    fileprivate func showError(message: String) {
        DispatchQueue.main.async {
            [weak self] in
            self?.view.endEditing(true)
            let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
            alert.addButton("OK".localized, action: {})
            alert.showError("Oops!".localized, subTitle: message)
        }
    }
fileprivate extension RFKeyboardToolbar {
    func addKey(_ key: String, to row: TextRow) {
        let button = RFToolbarButton(title: key)
        button?.addEventHandler({
            row.cell.textField.insertText(key)
            row.value = row.cell.textField.text
        }, for: .touchUpInside)
        self.buttons.append(button!)
    }
}
