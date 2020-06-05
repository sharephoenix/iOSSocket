//
//  ViewController.swift
//  SocketProject
//
//  Created by touch on 2020/6/5.
//  Copyright © 2020 touch. All rights reserved.
//

import UIKit
import SocketPod

class ViewController: UIViewController {
    private let ma = WebSocektManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        ma.connect()
    }
}

