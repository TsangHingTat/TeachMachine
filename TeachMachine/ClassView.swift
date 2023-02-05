//
//  ClassView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/4/23.
//

import SwiftUILib_DocumentPicker
import FilePicker
import SwiftUI
import Foundation


struct ClassView: View {
    @EnvironmentObject var externalDisplayContent: ExternalDisplayContent
    @State var docView = false
    @State var alldata: String
    @State var title: String
    
    @State var files: Array<String> = []
    @State var opening = "nil"
    @State var opentv = "nil"
    
    var body: some View {
        HStack {
            VStack {
                NavigationView {
                    List {
                        if files == [] {
                            Text("add a file")
                        } else {
                            ForEach(files, id: \.self) { i in
                                if i[0 ..< 5] == "lkcn." {
                                    let parsed = i.replacingOccurrences(of: "lkcn.", with: "")
                                    let parsed2 = parsed.replacingOccurrences(of: "lkcu.", with: "")
                                    let parsed3 = parsed2.replacingOccurrences(of: "%20", with: " ")
                                    let filepath = files[Int(files.lastIndex(of: i) ?? 0)+Int(1)]
                                    NavigationLink(destination: Fileview(name: parsed3, path: filepath)
                                        .toolbar {
                                            Button("cast") {
                                                opentv = opening
                                                externalDisplayContent.string = opening
                                                
                                            }
                                        }, label: {
                                        Text(parsed3)
                                    })
                                }
                                
                            }
                        }
                    }
                    .toolbar {
                        FilePicker(types: [.init(filenameExtension: "pdf")!, .init(filenameExtension: "swift")!], allowMultiple: false, title: "Add file") { urls in
                            let theFileName = ("\(urls[0])" as NSString).lastPathComponent
                            files.append(contentsOf: ["lkcn.\(theFileName)", "\(urls[0])"])
                            print(urls)
                        }
                    }
                    .navigationTitle("Files")
                }
                
            }
            
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
    
    
}


struct Fileview: View {
    var name: String
    var path: String
    var body: some View {
        VStack {
            TaskSwipeGesture(urlWeb: "\(path)")
        }
        .navigationBarTitle(name)
    }
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

