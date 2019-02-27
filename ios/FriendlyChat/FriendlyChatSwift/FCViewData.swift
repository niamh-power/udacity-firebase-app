//
//  FCViewDAta.swift
//  FriendlyChatSwift
//
//  Created by Niamh Power on 15/07/2017.
//  Copyright © 2017 Google Inc. All rights reserved.
//

import Foundation
import Firebase

struct FCViewData {
    var messages: [FIRDataSnapshot]
    var messageLength: Int
    var displayName: String
}

extension FCViewData {
    static func defaultData() -> FCViewData {
        let messages = [
            FIRDataSnapshot(),
            FIRDataSnapshot()
        ]
        let messageLength = 1000
        return FCViewData(messages: messages,
                          messageLength: messageLength,
                          displayName: "Anonymous")
    }
}
