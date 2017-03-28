//
//  ChatRoomViewController.swift
//  FriendlyChatSwift
//
//  Created by Niamh Power on 28/03/2017.
//  Copyright © 2017 Google Inc. All rights reserved.
//

import UIKit

final class ChatRoomViewController: UIViewController {
    private let viewModel: ChatRoomViewModel

    init(with viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
