//
//  FCViewModel.swift
//  FriendlyChatSwift
//
//  Created by Niamh Power on 12/07/2017.
//  Copyright © 2017 Google Inc. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FCViewModel {
    private var databaseReference: FIRDatabaseReference
    private var firebaseRemoteConfig: FIRRemoteConfig
    private var storageReference: FIRStorageReference

    fileprivate var _refHandle: FIRDatabaseHandle!
    private var msglength: NSNumber = 1000
    var didFail: ((NSError) -> Void)?

    var didAddChild: ((_ snapshot: FIRDataSnapshot) -> Void)?

    init(databaseReference: FIRDatabaseReference,
         firebaseRemoteConfig: FIRRemoteConfig,
         storageReference: FIRStorageReference) {
        self.databaseReference = databaseReference
        self.firebaseRemoteConfig = firebaseRemoteConfig
        self.storageReference = storageReference
    }

    func ready() {
        configureDatabase()
    }

    private func configureDatabase() {
        _refHandle = databaseReference.child("messages").observe(.childAdded) { [weak self] (snapshot: FIRDataSnapshot) in
            self?.didAddChild?(snapshot)
        }
    }

    private func configureRemoteConfig() {
        let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        firebaseRemoteConfig.configSettings = remoteConfigSettings!
    }

    func sendMessage(data: [String:String]) {
        var mdata = data
        mdata[Constants.MessageFields.name] = "Test"
        databaseReference.child("messages").childByAutoId().setValue(mdata)
    }
}
