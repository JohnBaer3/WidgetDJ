//
//  LidToggleIntent.swift
//  WidgetDJ
//
//  Created by John Baer on 6/17/23.
//

import SwiftUI
import AppIntents
import WidgetKit

struct LidToggleIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle a Todo"
    
    @Parameter(title: "Todo")
    var open: Bool
    
    init() {}

    init(open: Bool) {
        self.open = open
    }
    
    // Business logic
    func perform() async throws -> some IntentResult {
        WidgetState.toggleLid()
        return .result()
    }
}

