//
//  newfileView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/6/23.
//

import SwiftUI

struct newfileView: View {
    var title: String
    @Binding var text: String
    var body: some View {
        TextField("Hi", text: $text)
        .navigationTitle(title)
    }
}

