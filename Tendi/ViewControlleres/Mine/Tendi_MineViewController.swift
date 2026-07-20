
import UIKit

class Tendi_MineViewController: BaseViewController {

    @IBOutlet weak var mine_h: UIImageView!
    @IBOutlet weak var mine_n: UILabel!
    @IBOutlet weak var mine_follower: UIButton!
    @IBOutlet weak var mine_following: UIButton!
    @IBOutlet weak var mine_dallar_l: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
    }
    
    // 更多
    @objc func navigationRightItemClick() {
        let vc = Tendi_SettingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tendi_dallarsClick(_ sender: Any) {
        let vc = Tendi_DallarViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tendi_followingAndfollowerClick(_ sender: UIButton) {
        if sender.tag == 985 {
            
        }else {
            
        }
    }
    
    

}
