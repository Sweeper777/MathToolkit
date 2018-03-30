import UIKit
import Eureka

class SettingsController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("significant figures option".localized)
        form.allSections.last! <<< PickerInlineRow<String>(tagSigiFigOption) {
            row in
            row.title = "Significant Figures".localized
            row.options = ["As accurate as possible", "1", "2", "3", "4", "5", "6", "7", "8", "9"].map { $0.localized }
            row.value = "As accurate as possible".localized
        }.onChange({ (row) in
            if let index = row.options.index(of: row.value!) {
                if index == 0 {
                    UserSettings.sigFigOption = .no
                } else if index > 0 {
                    UserSettings.sigFigOption = .yes(index)
                }
            }
        })
    }
    
    @IBAction func done() {
        self.dismiss(animated: true, completion: nil)
    }
}

let tagSigiFigOption = "sigFigOption"
