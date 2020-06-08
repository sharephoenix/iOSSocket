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

let appKey = "4884122775716864"
let appSecrect  = "2064868b7cb443a8a820488e5d9ed621"

class ViewController: UIViewController {
    
    private var urlList = [
        "ws://openai.100tal.com/aievl/en",
        "ws://192.168.40.114:8000",
        "http://10.1.65.168:8769/aisvcdemo/postJson?access_key_id=4381305305940992&signature=aeD0GBCw1oupXCO0jWjZiaX4yJk%3D&signature_nonce=D170DB1E-EEED-463B-AA01-D8671E9E3956&timestamp=2020-06-08T14:21:58"
    ]
    
    private lazy var wsSocket: WebSocektManager = {
        let socket = WebSocektManager(wsUrl: urlList[2])
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

