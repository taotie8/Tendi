
import UIKit

class Tendi_PlayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
    }
    
    @objc func navigationRightItemClick() {
        
    }

}
