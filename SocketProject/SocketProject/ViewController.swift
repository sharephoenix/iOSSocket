//
//  ViewController.swift
//  SocketProject
//
//  Created by touch on 2020/6/5.
//  Copyright © 2020 touch. All rights reserved.
//

import UIKit
import SocketPod

func podLog(msg: String, func: String = #function) {
    print("\(msg)\t\(`func`)")
}

class ViewController: UIViewController {
    private var urlList = [
        "ws://openai.100tal.com/aievl/en",
        "ws://192.168.40.114:8000"
    ]
    
    private lazy var wsSocket: WebSocektManager = {
        let socket = WebSocektManager(wsUrl: urlList[0])
        socket.startDebug = true
        return socket
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wsSocket.connect()
        createActions()
    }
    
    @IBAction func emitAction(_ sender: Any) {
        let msg = "{\"portocal\": \"boardcast\", \"from\": \"client\", \"message\": \"hello\"}"
        wsSocket.emit(content: msg)
    }
    
    private func createActions() {
        wsSocket.onCallback = { msg in
            podLog(msg: msg)
        }
        wsSocket.onErrorCallback = { error in
            podLog(msg: "\(error.localizedDescription)")
        }
    }
}

