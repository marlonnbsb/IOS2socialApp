//
//  UserTableViewController.swift
//  SocialKit
//
//  Created by Pedro Henrique on 12/04/21.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"

    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared

            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    if let users = try? JSONDecoder().decode([User].self, from: data!) {
                        DispatchQueue.main.async {
                            self.users = users
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let user = users[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! UserTableViewCell
        
        cell.user = user
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "onUserSegue" {
            print("Sender: \(sender ?? "não veio!")")
            
            if let userCell = sender as? UserTableViewCell, let user = userCell.user {
                segue.destination.title = user.name
                guard let destination = segue.destination as? PostTableViewController else {return}
                destination.userId = user.id
            }
        }
    }
    
}
