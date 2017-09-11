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

    @IBOutlet weak var logInButton: UIButton!
    
    
    // MARK: - Built-in
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        setLogInState(loggedIn: service.isLoggedIn)
    }
    
    
    // MARK: - Actions
    @IBAction func logInButtonTapped(_ sender: Any) {
        if service.isLoggedIn {
            service.logout()
            setLogInState(loggedIn: false)
        } else {
            service.login(from: self) {
                error in
                if let unwrappedError = error {
                    NSLog("Error logging in: \(unwrappedError)")
                } else {
                    NSLog("Successfully logged in.")
                    self.setLogInState(loggedIn: true)
                }
            }
        }
    }
    
    func setLogInState(loggedIn: Bool) {
        if loggedIn {
            logInButton.setTitle("Log Out", for: UIControlState.normal)
        } else {
            logInButton.setTitle("Log In", for: UIControlState.normal)
        }
    }
}

