import UIKit
import Eureka
import ViewRow
import RFKeyboardToolbar
import SCLAlertView
import MathParser
import EZLoadingActivity

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
                imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
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
        
        form +++ ButtonRow() {
            row in
            row.title = "Toggle Help".localized
        }
            .cellUpdate({ (cell, row) in
            cell.textLabel?.textColor = UIColor(hex: "3b7b3b")
        })
        
        let helpSection = Section()
        for input in operation.inputs {
            helpSection <<< LabelRow() {
                row in
                var description = "\(input.name) - \(input.description.localized)"
                if input.rejectFloatingPoint {
                    description += " (integer only)".localized
                }
                row.title = description.replacingOccurrences(of: "ANGLE_MEASURE", with: UserSettings.useDegrees ? "degrees".localized : "radians".localized)
            }
        }
    }
    
    @IBAction func calculate() {
        func doInBackground() -> [[OperationResult]]? {
            if let inputValues = self.processInputs() {
                let results = self.operation.calculate(inputs: inputValues) ?? []
                let groupedResults = results.groupBy { $0.name }
                return groupedResults
            }
            return nil
        }
        
        EZLoadingActivity.show("Loading...".localized, disableUI: true)
        doInBackground ~> { [weak self] results in
            EZLoadingActivity.hide()
            if results != nil {
                self?.performSegue(withIdentifier: "showResults", sender: results)
            }
        }
    }
    
    func processInputs() -> [String: Double]? {
        let values = form.values()
        var inputValues = [String: Double]()
        for input in operation.inputs {
            if let expr = values[input.name] as? String {
                if expr.trimmed() != "" {
                    var evaluator = Evaluator.shared
                    evaluator.angleMeasurementMode = UserSettings.useDegrees ? .degrees : .radians
                    if let evaluated = try? evaluator.evaluate(Expression(string: expr), substitutions: [
                        "A": UserSettings.aValue,
                        "B": UserSettings.bValue,
                        "C": UserSettings.cValue,
                        "pi": UserSettings.valueOfPi
                        ]) {
                        if input.rejectFloatingPoint && evaluated.truncatingRemainder(dividingBy: 1) != 0 {
                            showError(message: String(format: "Input '%@' must be an integer!".localized, input.name))
                            return nil
                        }
                        inputValues[input.name] = evaluated
                    } else {
                        showError(message: String(format: "An error occurred while parsing expression for input '%@'".localized, input.name))
                        return nil
                    }
                }
            }
        }
        return inputValues
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultController {
            if let results = sender as? [[OperationResult]] {
                if results.count != 0 {
                    vc.results = results
                }
            }
        }
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
