//
//  TouchBar.swift
//  NyanLoop
//
//  Created by Hori,Masaki on 2017/06/27.
//  Copyright © 2017年 Hori,Masaki. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
class TouchBar: NSViewController {
    
    @IBOutlet var nyan: NSTextField!
    
    @IBOutlet var nyanBar: NSTouchBar!
    
    var archive: Data!
    
    override init?(nibName: String?, bundle: Bundle?) {
        
        super.init(nibName: nil, bundle: nil)
        
        var topLevel: NSArray = []
        Bundle.main.loadNibNamed("TouchBar", owner: self, topLevelObjects: &topLevel)
        
        archive = NSKeyedArchiver.archivedData(withRootObject: nyan)
        guard let _ = archive else { fatalError("could not archive Nyan.") }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            
            guard let `self` = self else { return }
            
            if arc4random_uniform(200) < 10 {
                
                self.doNyan()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var touchBar: NSTouchBar? {
        get { return nyanBar }
        set {}
    }
    
    func doNyan() {
        
        guard let newNyan = NSKeyedUnarchiver.unarchiveObject(with: archive) as? NSTextField
            else { return print("could not unarchive Nyan.") }
        
        NSAnimationContext.runAnimationGroup({ context in
            
            let size = view.frame.size
            
            var frame = newNyan.frame
            frame.origin.x = size.width
            newNyan.frame = frame
            view.addSubview(newNyan)
            
            frame.origin.x = -200
            
            context.duration = Double(3 + arc4random_uniform(8))
            newNyan.animator().frame = frame
            
        }) {
            newNyan.removeFromSuperview()
        }
        
    }
    
    override func touchesBegan(with event: NSEvent) {
        
        AppDelegate.shared().changeFace()
    }
}
