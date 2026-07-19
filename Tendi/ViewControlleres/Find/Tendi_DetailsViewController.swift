
import UIKit

class Tendi_DetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Tendi_DetailsHeaderCell", bundle: nil), forCellReuseIdentifier: "header")
        tableView.register(UINib(nibName: "Tendi_CommentsCell", bundle: nil), forCellReuseIdentifier: "comment")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func nav_backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}

extension Tendi_DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! Tendi_DetailsHeaderCell
            header.backgroundColor = .clear
            header.selectionStyle = .none
            
            return header
        }
        
        let header = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! Tendi_CommentsCell
        header.backgroundColor = .clear
        header.selectionStyle = .none
        
        return header
    }
}
