//
//  WidgetDJWidgetLiveActivity.swift
//  WidgetDJWidget
//
//  Created by John Baer on 6/11/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetDJWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetDJWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetDJWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetDJWidgetAttributes {
    fileprivate static var preview: WidgetDJWidgetAttributes {
        WidgetDJWidgetAttributes(name: "World")
    }
}

extension WidgetDJWidgetAttributes.ContentState {
    fileprivate static var smiley: WidgetDJWidgetAttributes.ContentState {
        WidgetDJWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetDJWidgetAttributes.ContentState {
         WidgetDJWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetDJWidgetAttributes.preview) {
   WidgetDJWidgetLiveActivity()
} contentStates: {
    WidgetDJWidgetAttributes.ContentState.smiley
    WidgetDJWidgetAttributes.ContentState.starEyes
}
