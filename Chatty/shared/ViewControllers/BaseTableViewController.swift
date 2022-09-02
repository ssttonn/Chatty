//
//  BaseTableViewController.swift
//  Chatty
//
//  Created by GONOSEN on 14/08/2022.
//

import UIKit

class BaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        self.navigationController?.setupCustomAppBar()
    }
}
