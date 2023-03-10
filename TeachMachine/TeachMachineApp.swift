//
//  TeachMachineApp.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/4/23.
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

import Combine

@main
struct TeachMachineApp: App {
    let persistenceController = PersistenceController.shared
    
    @ObservedObject var externalDisplayContent = ExternalDisplayContent()
#if os(iOS)
    @State var additionalWindows: [UIWindow] = []
#endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(externalDisplayContent)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
#if os(iOS)
                .onReceive(screenDidConnectPublisher, perform: screenDidConnect)
                .onReceive(screenDidDisconnectPublisher, perform: screenDidDisconnect)
#endif
        }
    }
#if os(iOS)
    private var screenDidConnectPublisher: AnyPublisher<UIScreen, Never> {
      NotificationCenter.default
        .publisher(for: UIScreen.didConnectNotification)
        .compactMap { $0.object as? UIScreen }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
        
    private var screenDidDisconnectPublisher: AnyPublisher<UIScreen, Never> {
      NotificationCenter.default
        .publisher(for: UIScreen.didDisconnectNotification)
        .compactMap { $0.object as? UIScreen }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    private func screenDidConnect(_ screen: UIScreen) {
       let window = UIWindow(frame: screen.bounds)

       window.windowScene = UIApplication.shared.connectedScenes
                .first { ($0 as? UIWindowScene)?.screen == screen }
                as? UIWindowScene

       let view = airplayView().environmentObject(externalDisplayContent)
       let controller = UIHostingController(rootView: view)
       window.rootViewController = controller
       window.isHidden = false
       additionalWindows.append(window)
            
       externalDisplayContent.isShowingOnExternalDisplay = true
    }
        
    private func screenDidDisconnect(_ screen: UIScreen) {
       additionalWindows.removeAll { $0.screen == screen }
       externalDisplayContent.isShowingOnExternalDisplay = false
    }
#endif
    
}



class ExternalDisplayContent: ObservableObject {
    @Published var string = ""
    @Published var isShowingOnExternalDisplay = false
//    @Published var image = UIImage()
}

