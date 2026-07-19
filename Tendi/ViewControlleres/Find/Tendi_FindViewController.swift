//
//  Tendi_FindViewController.swift
//  Tendi
//
//  Created by Mac on 2026/7/19.
//

import UIKit

class Tendi_FindViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "Tendi_FindTableViewCell", bundle: nil), forCellReuseIdentifier: "find")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func tendi_bananerClick(_ sender: Any) {
        
    }
    

}
extension Tendi_FindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let find = tableView.dequeueReusableCell(withIdentifier: "find", for: indexPath) as! Tendi_FindTableViewCell
        find.backgroundColor = .clear
        find.selectionStyle = .none
        
        return find
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = Tendi_DetailsViewController()
        detail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detail, animated: true)
    }
}
