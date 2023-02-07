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
    
    @State var allquestiondatas: Array<String> = []
    @State var all: Array<String> = []
    
    var body: some View {
        List {
            if allquestiondatas != [] {
                ForEach((1...allquestiondatas.count), id: \.self) { i in
                    NavigationLink(destination: McView(datas: $allquestiondatas[i-1]), label: {
                        Text("\(i). \(getname(str: allquestiondatas[i-1]))")
                        
                    })
                }
            }
             
        }
        .navigationTitle(title)
        .onAppear(perform: {
            all = getdata().stringtoarray(string: text)
            allquestiondatas = getdata().stringtoarray2(string: all[0])
        })
    }
    func getname(str: String) -> String {
        let array = getdata().stringtoarray3(string: str)
        let question = array[0]
        return question
    }
}

struct McView: View {
    @Binding var datas: String
    
    @State var question = ""
    @State var ans: Array<String> = []
    var body: some View {
        List {
            Section {
                TextField("question", text: $question)
            }
            if ans != [] {
                ForEach((1...ans.count), id: \.self) { i in
                    TextField("ans", text: $ans[i-1])
                }
                .onDelete { indexSet in
                    let a = "\(indexSet)"
                    if let b = Int.parse(from: a) {
                        ans.remove(at: b-1)
                    }
                }
            }
            Section {
                Button("add ans") {
                    ans.append("")
                }
            }
        }
        
        .onChange(of: question, perform: { value in
            var array = getdata().stringtoarray3(string: datas)
            array[0] = question
            datas = getdata().arraytostring3(array: array)
        })
        .onChange(of: ans, perform: { value in
            var array1 = getdata().stringtoarray3(string: datas)
            if array1.count > 2 {
                
            } else {
                array1.append("")
            }
            array1[1] = "\(getdata().arraytostring4(array: ans))"
            datas = getdata().arraytostring3(array: array1)
        })
        .onAppear(perform: {
            let array = getdata().stringtoarray3(string: datas)
            question = array[0]
            if array.count > 2 {
                ans = getdata().stringtoarray4(string: array[1])
            } else {
                question.append("")
            }
        })
        .navigationTitle(question)
#if os(iOS)
        .toolbar {
            EditButton()
        }
#endif

    }
        
}
