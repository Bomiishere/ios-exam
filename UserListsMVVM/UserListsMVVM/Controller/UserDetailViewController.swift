//
//  UserDetailViewController.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserDetailViewModel = UserDetailViewModel() {
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.title
        
    }
    
    //MARK: <TableView Datasource>
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.titles[indexPath.row]
        
        cell.detailTextLabel?.text = self.viewModel.descriptions[indexPath.row]
        
        return cell
    }
    
    //MARK: <TableView Datasource>
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
