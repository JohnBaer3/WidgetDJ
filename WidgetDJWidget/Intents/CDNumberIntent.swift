//
//  CDNumberIntent.swift
//  WidgetDJWidgetExtension
//
//  Created by John Baer on 6/19/23.
//

import Foundation
import SwiftUI
import AppIntents
import WidgetKit

struct CDNumberIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle the CD number"
    
    @Parameter(title: "cdNumber")
    var cdNumber: Int
    
    init() {}

    init(cdNumber: Int) {
        self.cdNumber = cdNumber
    }
    
    // Business logic
    func perform() async throws -> some IntentResult {
        WidgetState.incrementCDNum()
        return .result()
    }
}
