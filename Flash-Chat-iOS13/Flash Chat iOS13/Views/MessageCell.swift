//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by omrobbie on 22/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {

    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgMe: UIImageView!
    @IBOutlet weak var imgYou: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewMessage.layer.cornerRadius = viewMessage.frame.size.height / 5
    }

    func parseData(item: Message) {
        if item.sender == Auth.auth().currentUser?.email {
            imgMe.isHidden = false
            imgYou.isHidden = true
            viewMessage.backgroundColor = UIColor(named: Constants.BrandColors.purpleLight)
            lblMessage.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            imgMe.isHidden = true
            imgYou.isHidden = false
            viewMessage.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            lblMessage.textColor = UIColor(named: Constants.BrandColors.purpleLight)
        }

        lblMessage.text = item.body
    }
}
