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
    @Environment(\.managedObjectContext) private var viewContext
    @State var docView = false
    @State var alldata: String
    @State var title: String
    
    @State var addViewshowing = false
    @State var filename = ""
    
    @Binding var alldata2: String
    
    @State var files: Array<String> = []
    @State var opening = "nil"
    @State var opentv = "nil"
    
    var body: some View {
        HStack {
            VStack {
                NavigationView {
                    List {
                        if files == [""] {
                            Text("add a file")
                        } else {
                            if files.count != 0 {
                                ForEach((1...files.count), id: \.self) { i in
                                    if files[i-1][0 ..< 5] == "lkcn." {
                                        let parsed = files[i-1].replacingOccurrences(of: "lkcn.", with: "")
                                        let parsed2 = parsed.replacingOccurrences(of: "lkcu.", with: "")
                                        let parsed3 = parsed2.replacingOccurrences(of: "%20", with: " ")
                                        NavigationLink(destination: newfileView(title: parsed3, text: $files[i-1+1]), label: {
                                            Text(parsed3)
                                        })
                                    }
                                }.onDelete { indexSet in
                                    let a = "\(indexSet)"
                                    if let b = Int.parse(from: a) {
                                        files.remove(at: b-1)
                                        files.remove(at: b-1)
                                    }
                                    
                                }
                            }
                            
                            
                        }
                    }
                    .toolbar {
                        Button("add file") {
                            addViewshowing = true
                        }
                        .navigationTitle("Files")
                        
                    }
                }
                
            }
            .onChange(of: files) { i in
                getdata().savedefaultsdata(type: "sfg\(title)", data: getdata().arraytostring(array: files))
            }
            .onAppear() {
                files = getdata().stringtoarray(string: getdata().getdefaultsdata(type: "sfg\(title)"))
            }
            
        }
        .sheet(isPresented: $addViewshowing) {
            NavigationStack {
                List {
                    Text("File name")
                    TextField("File name", text: $filename)
                    Section {
                        Button("add file") {
                            files.append(contentsOf: ["lkcn.\(filename)", ""])
                            filename = ""
                            addViewshowing.toggle()
                            getdata().savedefaultsdata(type: "sfg\(title)", data: getdata().arraytostring(array: files))
                        }
                    }
                }
                .navigationBarTitle("Add a file")
            }
        }
#if os(iOS)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
#endif
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


extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
