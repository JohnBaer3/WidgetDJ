//
//  ToggleCDIntent.swift
//  ToggleCDIntent
//
//  Created by John Baer on 6/17/23.
//

import AppIntents

struct ToggleCDIntent: AppIntent {
    static var title: LocalizedStringResource = "ToggleCDIntent"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
