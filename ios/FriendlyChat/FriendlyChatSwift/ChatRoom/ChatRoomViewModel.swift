//
//  ChatRoomPresenter.swift
//  FriendlyChatSwift
//
//  Created by Niamh Power on 28/03/2017.
//  Copyright © 2017 Google Inc. All rights reserved.
//

import Foundation

class ChatRoomViewModel {
    private var viewData: ChatRoomViewData {
        didSet {
            didChangeViewData?(viewData)
        }
    }

    var didChangeViewData: ((ChatRoomViewData) -> Void)?

    init(viewData: ChatRoomViewData) {
        self.viewData = viewData
    }
}
