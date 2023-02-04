//
//  ClassView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/4/23.
//

import SwiftUI

struct ClassView: View {
    @State var title: String
    var body: some View {
        NavigationView {
            Text(title)
        }
        .navigationTitle(title)
    }
}

