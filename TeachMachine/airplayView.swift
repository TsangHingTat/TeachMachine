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
            WebView(url: "\(externalDisplayContent.string)")
        } 
    }
}

struct airplayView_Previews: PreviewProvider {
    static var previews: some View {
        airplayView()
    }
}
