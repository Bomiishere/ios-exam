//
//  UserListViewController.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Viewer {
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var viewModel: UserListViewModel! {
        didSet {
            self.title = self.viewModel.title
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
        
        self.tableView.tableFooterView = UIView()
        
        self.viewModel = UserListViewModel(vc: self)
        
        self.viewModel.loadUsers()
    }
    
    //MARK: <TableView Datasource>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath)
        
        let userViewModel = self.viewModel.users[indexPath.row]
        
        if let cell = cell as? UserListTableViewCell {
            cell.titleLabel.text = "\(userViewModel.firstName ?? "") \(userViewModel.lastName ?? "")"
        }
        
        return cell
    }
    
    //MARK: <TableView Datasource>
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let pvc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            return
        }
        pvc.viewModel = UserDetailViewModel(user: self.viewModel.users[indexPath.row])
        self.navigationController?.pushViewController(pvc, animated: true)
    }
}

