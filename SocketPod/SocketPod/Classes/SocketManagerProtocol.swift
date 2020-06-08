//
//  SocketManagerProtocol.swift
//  SocketProject
//
//  Created by touch on 2020/6/5.
//  Copyright © 2020 touch. All rights reserved.
//

import UIKit

protocol SocketManagerProtocol {
    init(wsUrl: String)
    var socketStatus: SocketStatus { get }
    var onCallback: ((String) -> Void)? { get set }
    var onErrorCallback: ((NSError) -> Void)? { get set}
    var onStatusCallback: ((SocketStatus, String) -> Void)? { get set }
    var startDebug: Bool { get set }
    func connect()
    func disConnect()
}
