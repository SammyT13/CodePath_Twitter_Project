//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sammy Torres II on 9/23/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
// This is linked to the 'Home' Screen and 'Logout' button
class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLogout(_ sender: Any) {
        // this is the logout function already created
        TwitterAPICaller.client?.logout()
        // this dismisses the Home screen after clicking logout
        self.dismiss(animated: true, completion: nil)
        // This sets the user is logged out - sets it to false
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
