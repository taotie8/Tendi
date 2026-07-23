
import UIKit

class Tendi_DallarViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dallar_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 66.1)/3, height: 137)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_DallarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
        
    }

}

extension Tendi_DallarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_DallarCollectionViewCell
        cell.backgroundColor = .clear
        
        cell.cell_bg.image = UIImage(named: "person_cell_bg")
        if indexPath.row == 9 {
            cell.cell_bg.image = UIImage(named: "dallar_99")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = Tendi_UserViewController()
        user.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(user, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 9 {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 137)
        }
        return CGSize(width: (UIScreen.main.bounds.width - 66.1)/3, height: 137)
    }
    
}

