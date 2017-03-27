//
//  FirebaseMock.swift
//  FriendlyChatSwift
//
//  Created by Niamh Power on 15/03/2017.
//  Copyright © 2017 Google Inc. All rights reserved.
//

import Foundation

class MockFIRAuth: FIRAuthProtocol {
    var signInAnonymouslyCalled = false
    func signInAnonymously(completion: ((FIRUserProtocol?, Error?) -> Void)? = nil) {
        signInAnonymouslyCalled = true
    }
}
