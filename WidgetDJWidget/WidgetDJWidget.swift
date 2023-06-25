//
//  WidgetDJWidget.swift
//  WidgetDJWidget
//
//  Created by John Baer on 6/11/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    let imageNames = ["clearBox", "safariBack", "clearBox", "safariBack", "clearBox", "safariBack", "clearBox", "safariBack"]
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WidgetDJWidgetEntryView : View {
    var entry: Provider.Entry
    
    @AppStorage("lidOpen", store: UserDefaults(suiteName: WidgetState.appGroup))
    var lidOpen: Bool = WidgetState.lidOpened()
    var lidOpenImage: String {
        if lidOpen {
            return "clearBox"
        } else {
            return "cdPlayerLid"
        }
    }
    
    var cdValue: Int = WidgetState.cdValue()
    let cdFrames: [String] = ["cd1", "cd2", "cd3", "cd4"]
    let cdOrangeFrames: [String] = ["cdOrange1", "cdOrange2", "cdOrange3", "cdOrange4"]
    let cdBlueFrames: [String] = ["cdBlue1", "cdBlue2", "cdBlue3", "cdBlue4"]

    var cdNum: Int = WidgetState.cdNumber()
    let cdNumValue: [String] = ["cd", "cdOrange", "cdBlue"]
    
    
    @State private var isSpinning = false
    @State private var buttonPressed = false
    @State private var toChange: Bool = false

    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Image("cdPlayer1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: 165, height: 165, alignment: .center)
                
                switch cdNum % 3 {
                case 0:
                    Image(cdFrames[cdValue % cdFrames.count])
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .id(cdNum)
                        .frame(width: 140, height: 140)
                        .transition(.push(from: .top))
                case 1:
                    Image(cdOrangeFrames[cdValue % cdOrangeFrames.count])
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .id(cdNum)
                        .frame(width: 140, height: 140)
                        .transition(.push(from: .top))
                case 2:
                    Image(cdBlueFrames[cdValue % cdBlueFrames.count])
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .id(cdNum)
                        .frame(width: 140, height: 140)
                        .transition(.push(from: .top))
                default:
                    EmptyView()
                }
                
                VStack {
                    Spacer()
                    HStack (alignment: .center) {
                        Button(intent: CDNumberIntent(cdNumber: cdNum)) {
                            Image("backButton")
                                .resizable()
                                .frame(width: 35, height: 20)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(intent: CDFrameIntent(cdVal: cdValue)) {
                            Image("playPauseButton")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(intent: CDNumberIntent(cdNumber: cdNum)) {
                            Image("fastForwardButton")
                                .resizable()
                                .frame(width: 35, height: 20)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }.offset(x: 0, y: -10)

                
                Image(lidOpenImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .id(lidOpen)
                    .transition(.push(from: .leading))
                    .animation(.smooth (duration: 2), value: lidOpen)
                    .frame(width: 153, height: 153, alignment: .center)
                    .offset(x: 0, y: 0)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(intent: LidToggleIntent(open: lidOpen)) {
                            Image("cdNotch")
                                .resizable()
                                .frame(width: 5, height: 20)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .offset(x: -4)
                    Spacer()
                }
//
//                        Button(intent: CDFrameIntent(cdVal: cdValue)) {
//                            Image(systemName: "play.circle.fill")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }.buttonStyle(PlainButtonStyle())
//                    }
//                    
//                    Spacer()
//                    
//                    Button(intent: CDNumberIntent(cdNumber: cdNum)) {
//                        Image(systemName: "play.circle.fill")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                    }
//                }
                
                
            }
            .offset(x: -20, y: -20)
        }
    }
    
    func someButtonAction() {
        
    }
}

struct WidgetDJWidget: Widget {
    let kind: String = "WidgetDJWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetDJWidgetEntryView(entry: entry)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        var intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        intent.imageString = "safariBack"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        var intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        intent.imageString = "clearBox"
        return intent
    }
}

#Preview(as: .systemSmall) {
    WidgetDJWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
