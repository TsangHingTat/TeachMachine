//
//  errorView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/4/23.
//

import SwiftUI

import SwiftUI

struct ErrorView: View {
    var errorcode = ""
    var body: some View {
        NavigationStack {
            VStack {
                Text("發生錯誤")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding()
                if errorcode == "" {
                    Text("頁面開發中")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)
                } else {
                    Text("\(errorcode)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationTitle("發生錯誤")
        }
    }
}



struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorcode: "(Preview)")
    }
}
