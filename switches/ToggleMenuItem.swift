//
//  ToggleMenuItem.swift
//  switches
//
//  Created by Nathan Dotz on 3/14/19.
//  Copyright © 2019 Nathan Dotz. All rights reserved.
//

import Cocoa

class ToggleMenuItem: NSMenuItem {

    var onOff: Bool = false
    let originalTitle:String
    let toggleable: Toggleable
    
    init(toggleable:Toggleable) {
        originalTitle = toggleable.title
        self.toggleable = toggleable
        super.init(title: toggleable.title, action: #selector(self.toggle), keyEquivalent: "")
        self.onOff = shell(toggleable.statusCommand) == 0
        self.title = getToggleTitle(onOff: onOff)
    }
    
    override init(title: String, action: Selector?, keyEquivalent: String) {
//        originalTitle = title
//        toggleable = Toggleable(title: "",statusCommand: "",startCommand: "",stopCommand: "")
//        super.init(title: title, action: action, keyEquivalent: keyEquivalent)
        fatalError("not implemented, use toggleable constructor")
    }
    
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["bash", "-c"] + args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    @objc func toggle() {
        onOff = !onOff
        self.title = getToggleTitle(onOff: onOff)
        if (onOff) {
            shell(toggleable.startCommand)
        } else {
            shell(toggleable.stopCommand)
        }
        sendNotification()
    }
    
    func getToggleTitle(onOff: Bool) -> String {
        if (onOff) {
            return "✓ \(self.originalTitle)"
        } else {
            return self.originalTitle
        }
    }
    
    func sendNotification() {
        
        let notification = NSUserNotification()
        notification.title = NSApplication.shared.accessibilityTitle()
        //notification.subtitle = "How are you?"
        notification.soundName = NSUserNotificationDefaultSoundName
        let state = onOff ? "on" : "off"
        notification.informativeText = "\(self.title) is now \(state)"
        
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.deliver(notification)
    }
}
