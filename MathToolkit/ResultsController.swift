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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?[section].count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return results?[section].first?.name.localized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MGSwipeTableCell
        if let result = results?[indexPath.section][indexPath.row] {
            cell.textLabel?.text = result.value.localized
            cell.detailTextLabel?.text = result.from
            let copyButton = MGSwipeButton(title: "Copy", backgroundColor: .gray)
            copyButton.callback = { [weak self] cell in
                UIPasteboard.general.string = cell.textLabel?.text as String?
                self?.showSuccess(message: "Copied to clipboard!".localized)
                return true
            }
            cell.leftButtons = [copyButton]
            if let value = Double(cell.textLabel!.text!) {
            }
            
        } else {
            cell.textLabel?.text = "No Results".localized
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    func showSuccess(message: String) {
        let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
        alert.addButton("OK".localized, action: {})
        alert.showSuccess("Success!".localized, subTitle: message)
    }
}
