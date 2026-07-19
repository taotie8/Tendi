
import UIKit

class Tendi_UserViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var user_header: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var user_follower_label: UILabel!
    @IBOutlet weak var user_following_label: UILabel!
    @IBOutlet weak var user_bio_label: UILabel!
    @IBOutlet weak var user_follow_button: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var centerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .white
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 148, height: 208)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
    }
    
    // 更多
    @objc func navigationRightItemClick() {
        guard let containerView = view.window ?? tabBarController?.view ?? view else { return }
        ChooseMoeView.show(in: containerView, reportAction: { [weak self] in
            let reportDetailViewController = ReportDetailViewController()
            reportDetailViewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(reportDetailViewController, animated: true)
        })
    }
    
    @IBAction func tendi_followStatusChatClick(_ sender: UIButton) {
        if sender.tag == 985 { // 关注
            
        }else { // 聊天
            
        }
    }
    

}

extension Tendi_UserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_UserCollectionViewCell
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = Tendi_UserViewController()
        user.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(user, animated: true)
    }
}
