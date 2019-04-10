//
//  StatusMenuController.swift
//  switches
//
//  Created by Nathan Dotz on 3/14/19.
//  Copyright © 2019 Nathan Dotz. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.button?.image = icon
        statusItem.menu = statusMenu
        
        statusMenu.autoenablesItems = true
        
        statusMenu.addItem(NSMenuItem.separator())
        
        let chunk = Toggleable(title: "chunkwm",
                               statusCommand: "/usr/local/Homebrew/bin/brew services list | grep \"chunkwm.*started\" &> /dev/null",
                               startCommand: "/usr/local/Homebrew/bin/brew services start chunkwm",
                               stopCommand: "/usr/local/Homebrew/bin/brew services stop chunkwm")
        
        for i in [chunk] {
            let item : ToggleMenuItem = ToggleMenuItem(toggleable: i)
            statusMenu.addItem(item)
        }
        
    }
    
}



