//
//  MessageCell.swift
//  outlook-api-tutorial
//
//  Created by Tomek Buslowski on 11.09.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Message {
    let from: String
    let received: String
    let subject: String
}

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var receivedLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    var from: String? {
        didSet {
            fromLabel.text = from
        }
    }
    
    var received: String? {
        didSet {
            receivedLabel.text = received
        }
    }
    
    var subject: String? {
        didSet {
            subjectLabel.text = subject
        }
    }
}

class MessagesDataSource: NSObject {
    let messages: [Message]
    
    init(messages: [JSON]?) {
        var msgArray = [Message]()
        
        if let unwrappedMessages = messages {
            for (message) in unwrappedMessages {
                let newMsg = Message(
                    from: message["from"]["emailAddress"]["name"].stringValue,
                    received: Formatter.dateToString(date: message["receivedDateTime"]),
                    subject: message["subject"].stringValue)
                
                msgArray.append(newMsg)
            }
        }
        
        self.messages = msgArray
    }
}

extension MessagesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageCell.self)) as! MessageCell
        let message = messages[indexPath.row]
        cell.from = message.from
        cell.received = message.received
        cell.subject = message.subject
        return cell
    }
}
