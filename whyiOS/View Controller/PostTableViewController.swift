
//
//  PostTableViewController.swift
//  whyiOS
//
//  Created by Cody on 9/5/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController, PostTableViewCellDelegate{
    func updateView() {
        tableView.reloadData()
    }
    
    
    let postController = PostController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadFetchChat()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postController.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        let post = postController.posts[indexPath.row]
        
        cell?.post = post
        
        return cell ?? UITableViewCell()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertController()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        loadFetchChat()
    }
    
    func presentAlertController(){
        let alertController = UIAlertController(title: "Add Reason", message: "Please fill out the text fields", preferredStyle: .alert)
        alertController.addTextField {(itemTextField) in
            itemTextField.placeholder = "Name..."
        }
        alertController.addTextField {(itemTextField) in
            itemTextField.placeholder = "Reason..."
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) {(_) in
            
            guard let name = alertController.textFields?[0].text,
                let reason = alertController.textFields?[1].text, name != "", reason != ""else {return}
            
            
            
            self.postController.putPost(name: name, reason: reason, completion: { (success) in
                if success{
                    DispatchQueue.main.async {
                        print("putPost worked 😀")
                    }
                }else{
                    DispatchQueue.main.async {
                        print("putPost didn't work 🤬")
                    }
                }
            })
            
            self.tableView.reloadData()
        }
        alertController.addAction(dismissAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    func loadFetchChat(){
        self.postController.fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
}
