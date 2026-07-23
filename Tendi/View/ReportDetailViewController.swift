
import UIKit

class ReportDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var cell_items = [String]()
    var cell_idx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Report"
        cell_items = ["report_discriminatory_insult", "report_false_rumors", "report_illegal_criminal", "report_infringement_rights", "report_malicious_harassment", "report_pornographic_vulgar", "report_provocation_war", "report_violence_terror"]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ReportTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    @IBAction func tendi_submitedClick(_ sender: UIButton) {
        guard cell_idx != nil else {
            TendiHUD.showToast("Please select a reason.", in: view)
            return
        }
        
        TendiHUD.showPrompt(
            in: view,
            title: "Report Submitted",
            message: "We have received your report and will review it as soon as possible.",
            primaryTitle: "OK",
            primaryAction: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }
}

extension ReportDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cell_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let report = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportTableViewCell
        report.backgroundColor = .clear
        report.selectionStyle = .none
        let imageName = cell_items[indexPath.item]
        report.cell_imageView.image = UIImage(named: "\(imageName)")
        if indexPath.item == cell_idx {
            report.cell_imageView.image = UIImage(named: "\(imageName)_s")
        }
        return report
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cell_idx = indexPath.item
        tableView.reloadData()
    }
}
