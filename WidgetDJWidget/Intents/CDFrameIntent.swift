//
//  CDFrameIntent.swift
//  WidgetDJ
//
//  Created by John Baer on 6/19/23.
//

import SwiftUI
import AppIntents
import WidgetKit

struct CDFrameIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle the CD"
    
    @Parameter(title: "cdValue")
    var cdVal: Int
    
    init() {}

    init(cdVal: Int) {
        self.cdVal = cdVal
    }
    
    // Business logic
    func perform() async throws -> some IntentResult {
        WidgetState.incrementCDVal()
        return .result()
    }
}

