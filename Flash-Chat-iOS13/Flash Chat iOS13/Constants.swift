//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by omrobbie on 22/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

struct Constants {

    static let appTitle = "⚡️FlashChat"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"

    struct FStore {

        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }

    struct BrandColors {

        static let blue = "BrandBlue"
        static let blueLight = "BrandLightBlue"
        static let purple = "BrandPurple"
        static let purpleLight = "BrandLightPurple"
    }
}
