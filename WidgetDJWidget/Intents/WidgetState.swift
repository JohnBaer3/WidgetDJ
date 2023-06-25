//
//  WidgetState.swift
//  WidgetDJ
//
//  Created by John Baer on 6/17/23.
//

import Foundation

struct WidgetState {
    
    static let appGroup = "<App Group Here>"

    static func toggleLid() {
        var val = lidOpened()
        val.toggle()
        
        print(val)
        UserDefaults(suiteName: appGroup)?.setValue(val, forKey: "lidOpen")
    }
    
    static func lidOpened() -> Bool {
        guard let lidOpen = UserDefaults(suiteName: appGroup)?.value(forKey: "lidOpen") as? Bool else {
            return false
        }
        return lidOpen
    }

    
    
    static func incrementCDVal() {
        var val = cdValue()
        val += 1
        
        print("cdVal: \(val)")
        UserDefaults(suiteName: appGroup)?.setValue(val, forKey: "cdValue")
    }
    
    static func cdValue() -> Int {
        guard let cdValue = UserDefaults(suiteName: appGroup)?.value(forKey: "cdValue") as? Int else {
            return 0
        }
        return cdValue
    }
    
    
    static func incrementCDNum() {
        var val = cdNumber()
        val += 1
        
        print("cdNum: \(val)")
        
        UserDefaults(suiteName: appGroup)?.setValue(val, forKey: "cdNumber")
    }
    
    static func cdNumber() -> Int {
        guard let cdNumber = UserDefaults(suiteName: appGroup)?.value(forKey: "cdNumber") as? Int else {
            return 0
        }
        return cdNumber
    }

}
