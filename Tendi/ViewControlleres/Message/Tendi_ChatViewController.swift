
import UIKit

class Tendi_ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var user_header: UIImageView!
    @IBOutlet weak var user_name_label: UILabel!
    @IBOutlet weak var tendi_textFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nav_backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nav_morebuttonAndCenterClick(_ sender: UIButton) {
   
    }
    
    @IBAction func sendChatMessageVideoChat(_ sender: UIButton) {
        
    }
    
    
}
