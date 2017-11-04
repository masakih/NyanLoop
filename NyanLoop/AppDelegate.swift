//
//  AppDelegate.swift
//  NyanLoop
//
//  Created by Hori,Masaki on 2017/06/27.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static let shared: AppDelegate = {
        return NSApplication.shared.delegate as! AppDelegate
    }()
    
    var docTile: DocTile!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        docTile = DocTile()
        
        NSApplication.shared.dockTile.contentView = docTile.view
        
        let size = NSApplication.shared.dockTile.size
        docTile.view.setFrameSize(size)
        
        updateDockTile()
    }

    func changeFace() {
        
        docTile.textField.stringValue = "😻"
        updateDockTile()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            
            self?.docTile.textField.stringValue = "😺"
            self?.updateDockTile()
        }
    }
    
    private func updateDockTile() {
        NSApplication.shared.dockTile.display()
    }
    
    var touchbar = TouchBar()
}

@available(OSX 10.12.2, *)
extension AppDelegate: NSTouchBarProvider {
    
    var touchBar: NSTouchBar? {
        get { return touchbar.touchBar }
        set {}
    }
}
