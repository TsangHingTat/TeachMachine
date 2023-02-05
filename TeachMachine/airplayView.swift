//
//  airplayView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/5/23.
//

import SwiftUI

struct airplayView: View {
    @EnvironmentObject var externalDisplayContent: ExternalDisplayContent
    var body: some View {
        if externalDisplayContent.string != "" {
#if os(iOS)
            VStack {
                WebView(url: "\(externalDisplayContent.string)")
            }
#elseif os(macOS)
            WebView(request: URLRequest(url: URL(string: "\(externalDisplayContent.string)")!))
#endif
        } 
    }
}

struct airplayView_Previews: PreviewProvider {
    static var previews: some View {
        airplayView()
    }
}
