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
        configureStorage()
    }

    private func configureDatabase() {
        _refHandle = databaseReference.child("messages").observe(.childAdded) { [weak self] (snapshot: FIRDataSnapshot) in
            self?.didAddChild?(snapshot)
        }
    }

    private func configureStorage() {
        storageReference = FIRStorage.storage().reference()
    }

    private func fetchConfig() {

    }

    private func configureRemoteConfig() {
        let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        firebaseRemoteConfig.configSettings = remoteConfigSettings!
    }

    func sendMessage(data: [String:String]) {
        if Reachability().connectedToNetwork() {
            var mdata = data
            mdata[Constants.MessageFields.name] = "Test"
            databaseReference.child("messages").childByAutoId().setValue(mdata)
        }
    }

    func sendPhotoMessage(photoData: Data) {
        if let currentUser = FIRAuth.auth()?.currentUser {
            let timestamp = "\(Double(Date.timeIntervalSinceReferenceDate * 1000))"
            let imagePath = "chat_photos/" + currentUser.uid + "/" + timestamp + ".jpg"
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"

            storageReference.child(imagePath).put(photoData, metadata: metadata) { [weak self] (metadata, error) in
                if let error = error { print("error uploading: \(error)")}

                self?.sendMessage(data: [Constants.MessageFields.imageUrl:
                                         self?.storageReference!.child((metadata?.path)!).description])
            }
        }
    }
}
