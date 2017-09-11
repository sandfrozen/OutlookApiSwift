//
//  MailViewController.swift
//  outlook-api-tutorial
//
//  Created by Tomek Buslowski on 08.09.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {
    
    // MARK: - Properties
    let service = OutlookService.shared()
    var dataSource: MessagesDataSource?

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Built-in
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogInState(loggedIn: service.isLoggedIn)
        if service.isLoggedIn {
            loadUserData()
        }
        
        self.tableView.estimatedRowHeight = 90.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func logInButtonTapped(_ sender: Any) {
        if (service.isLoggedIn) {
            // Logout
            service.logout()
            setLogInState(loggedIn: false)
        } else {
            // Login
            service.login(from: self) {
                error in
                if let unwrappedError = error {
                    NSLog("Error logging in: \(unwrappedError)")
                } else {
                    NSLog("Successfully logged in.")
                    self.setLogInState(loggedIn: true)
                    self.loadUserData()
                }
            }
        }    }
    
    func setLogInState(loggedIn: Bool) {
        if loggedIn {
            logInButton.setTitle("Log Out", for: UIControlState.normal)
        } else {
            logInButton.setTitle("Log In", for: UIControlState.normal)
        }
    }
    
    func loadUserData() {
        service.getUserEmail() {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)")
                
                self.service.getInboxMessages() {
                    messages in
                    if let unwrappedMessages = messages {
                        self.dataSource = MessagesDataSource(messages: unwrappedMessages["value"].arrayValue)
                        self.tableView.dataSource = self.dataSource
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

