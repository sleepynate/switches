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
        
        let chunk = Toggleable(title: "tiling",
                               statusCommand: "/usr/local/Homebrew/bin/brew services list | grep \"yabai.*started\" &> /dev/null",
                               startCommand: "/usr/local/Homebrew/bin/brew services start yabai",
                               stopCommand: "/usr/local/Homebrew/bin/brew services stop yabai")
        let skhd = Toggleable(title: "key bindings",
                              statusCommand: "/usr/local/Homebrew/bin/brew services list | grep \"skhd.*started\" &> /dev/null",
                              startCommand: "/usr/local/Homebrew/bin/brew services start skhd",
                              stopCommand: "/usr/local/Homebrew/bin/brew services stop skhd")
        for i in [chunk, skhd] {
            let item : ToggleMenuItem = ToggleMenuItem(toggleable: i)
            statusMenu.addItem(item)
        }
        
    }
    
}



