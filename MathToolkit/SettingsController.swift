import UIKit
import Eureka

class SettingsController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("significant figures option".localized)
        form.allSections.last! <<< PickerInlineRow<String>(tagSigiFigOption) {
            row in
            row.title = "Significant Figures".localized
            let options = ["Most accurate", "1", "2", "3", "4", "5", "6", "7", "8", "9"].map { $0.localized }
            row.options = options
            switch UserSettings.sigFigOption {
            case .no: row.value = options[0]
            case .yes(let sigFig): row.value = options[sigFig]
            }
        }.onChange({ (row) in
            if let index = row.options.index(of: row.value!) {
                if index == 0 {
                    UserSettings.sigFigOption = .no
                } else if index > 0 {
                    UserSettings.sigFigOption = .yes(index)
                }
            }
        })
        
        form +++ PickerInlineRow<String>(tagValueOfPi) {
            row in
            row.title = "Value of π".localized
            let options = ["\(Double.pi)", "3.1416", "3.14", "22 / 7"]
            row.options = options
            row.value = options[UserSettings.valueOfPiOption]
        }
        .onChange({ (row) in
            if let index = row.options.index(of: row.value!) {
                UserSettings.valueOfPiOption = index
            }
        })
        
        form +++ SegmentedRow<String>(tagUseDegrees) {
            row in
            row.title = "Angles in".localized
            row.options = ["Radians", "Degrees"]
            row.value = UserSettings.useDegrees ? "Degrees" : "Radians"
        }
        .onChange({ (row) in
            if let index = row.options?.index(of: row.value!) {
                UserSettings.useDegrees = index == 1
            }
        })
    }
    
    @IBAction func done() {
        self.dismiss(animated: true, completion: nil)
    }
}

let tagSigiFigOption = "sigFigOption"
let tagValueOfPi = "valueOfPi"
let tagUseDegrees = "useDegrees"
