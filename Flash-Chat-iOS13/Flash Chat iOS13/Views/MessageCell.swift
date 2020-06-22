//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by omrobbie on 22/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

    func parseData(item: Message) {
        lblMessage.text = item.body
    }
}
