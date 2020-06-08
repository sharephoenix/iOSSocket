//
//  SocketManager.swift
//  SocketProject
//
//  Created by touch on 2020/6/5.
//  Copyright © 2020 touch. All rights reserved.
//

import UIKit
import Foundation
import SocketIO
import Starscream
import SocketRocket

func podLog(msg: String, func: String = #function, debug: Bool = false) {
    if debug {
        print("\(msg)\t\(`func`)")
    }
}

public enum SocketStatus {
    case connected
    case disConnect
}

public class WebSocektManager: NSObject, SocketManagerProtocol {
    
    private var urlStr: String
    
    private var socket: WebSocket!
    
    public var startDebug = false
    public var onCallback: ((String) -> Void)?
    public var onErrorCallback: ((NSError) -> Void)?
    
    public var socketStatus: SocketStatus {
        var status: SocketStatus = .disConnect
        switch socket.isConnected {
        case true:
            status = .connected
        default:
            status = .disConnect
        }
        return status
    }
    
    public required init(wsUrl: String) {
        urlStr = wsUrl
    }
    
    public func connect() {
        connectTest1()
    }
    
    public func emit(content: String) {
        write1(msg: content)
    }

    // MARK: - Private Function
    private func connectTest1() {
        defer {
            podLog(msg: "start", debug: startDebug)
        }
        var request = URLRequest(url: URL(string: urlStr)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    private func write1(msg: String) {
        podLog(msg: "\(socket.isConnected)", debug: startDebug)
        if !socket.isConnected {
            socket.connect()
            podLog(msg: "begin Connect!!!")
            return
        }
        socket.write(string: msg)
    }
    
    deinit {
        socket.disconnect()
    }
}
// MARK: webSocketDelegate
extension WebSocektManager: WebSocketDelegate {

    public func websocketDidConnect(socket: WebSocketClient) {
        podLog(msg: "", debug: startDebug)
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        podLog(msg: "\(String(describing: error))", debug: startDebug)
        let err = NSError(domain: error.debugDescription, code: -1, userInfo: nil)
        onErrorCallback?(err)
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        onCallback?(text)
        podLog(msg: text, debug: startDebug)
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        podLog(msg: "", debug: startDebug)
    }
}
