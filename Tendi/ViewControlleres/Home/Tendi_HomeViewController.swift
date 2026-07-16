

import UIKit

class Tendi_HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var discover_button: UIButton!
    @IBOutlet weak var follow_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 118, height: 148)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
    }

    @IBAction func tap_discoverAndFollowClick(_ sender: UIButton) {
        discover_button.setImage(UIImage(named: "home_discover"), for: .normal)
        follow_button.setImage(UIImage(named: "home_follow"), for: .normal)
        if sender.tag == 321 {
            discover_button.setImage(UIImage(named: "home_discover_s"), for: .normal)
        }
        else {
            follow_button.setImage(UIImage(named: "home_follow_s"), for: .normal)
        }
    }
    

}

extension Tendi_HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_HomeCollectionViewCell
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
