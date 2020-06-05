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
    
public class WebSocektManager: NSObject {
    private var manager: SocketManager!
    private var onCallBack: ((Any) -> Void)?
    
    public func connect() {
        manager = SocketManager(socketURL: URL(string: "http://192.168.40.114:2080")!, config: [.log(true), .compress])
        let socket = manager.defaultSocket

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }

        socket.on("data") {data, ack in
            print("===========Data")
            print("\(data)")
            print("\(ack)")
        }

        socket.on("client") {data, ack in
            print("===========Data")
            print("\(data)")
            print("\(ack)")
        }

        socket.on("end") {data, ack in
            print("===========End")
            print("\(data)")
            print("\(ack)")
        }

        socket.connect()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////            "{\"portocal\": \"boardcast\", \"from\": \"client\", \"message\": \"hello\"}"
//           socket.emitWithAck("currentAmount", "{\"portocal\": \"boardcast\", \"from\": \"client\", \"message\": \"hello\"}").timingOut(after: 0) {data in
//            print("\(data)")
//            }
//            print("asdfkja;")
//        }
    }
}
