import UIKit
import Eureka

class SettingsController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("significant figures option".localized)
        form.allSections.last! <<< PickerInlineRow<String>(tagSigiFigOption) {
            row in
            row.title = "Significant Figures"
            row.options = ["As accurate as possible", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            row.value = "As accurate as possible"
        }
    }
    
    @IBAction func done() {
        self.dismiss(animated: true, completion: nil)
    }
}

let tagSigiFigOption = "sigFigOption"
