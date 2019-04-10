//
//  Toggleable.swift
//  switches
//
//  Created by Nathan Dotz on 4/10/19.
//  Copyright © 2019 Nathan Dotz. All rights reserved.
//

import Cocoa

class Toggleable: NSObject {
    
    let title: String
    let statusCommand: String
    let startCommand: String
    let stopCommand: String
    
    init(title: String, statusCommand: String, startCommand: String, stopCommand: String) {
        self.title = title
        self.statusCommand = statusCommand
        self.startCommand = startCommand
        self.stopCommand = stopCommand
    }
}
