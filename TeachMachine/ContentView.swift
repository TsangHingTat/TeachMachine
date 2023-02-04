//
//  ContentView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/4/23.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var externalDisplayContent: ExternalDisplayContent
    @State var isseledteachermode = false
    @State var isteachermode = false
    var body: some View {
        if isseledteachermode {
            if isteachermode {
                TeacherView()
                    .environmentObject(externalDisplayContent)
            } else {
                ErrorView()
            }
        } else {
            VStack {
                Spacer()
                Text("TeachMachine")
                    .font(.largeTitle)
                Spacer()
                VStack {
                    Button(action: {
                        isseledteachermode = true
                        isteachermode = true
                    }, label: {
                        VStack {
                            Text("我是學生")
                                .font(.largeTitle)
                        }
                    })
                    .padding()
                    Button(action: {
                        isseledteachermode = true
                        isteachermode = false
                    }, label: {
                        VStack {
                            Text("我是老師")
                                .font(.largeTitle)
                        }
                    })
                    .padding()
                }
                Spacer()
                    .onAppear() {
                        isteachermode = getdata().getdefaultsdatabool(type: "isteachermod")
                        isseledteachermode = getdata().getdefaultsdatabool(type: "isseledteachermode")
                    }
                    .onReceive(timer) { input in
                        getdata().savedefaultsdatabool(type: "isteachermod", data: isteachermode)
                        getdata().savedefaultsdatabool(type: "isseledteachermode", data: isseledteachermode)
                    }
            }
            
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
