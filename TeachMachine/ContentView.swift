//
//  ContentView.swift
//  TeachMachine
//
//  Created by HingTatTsang on 2/4/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>

    @State var popover = false
    @State var textedit = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ClassView(title: item.name ?? "")
                    } label: {
                        Text(item.name ?? "")
                    }
                }
                .onDelete(perform: deleteItems)
                
            }
            .navigationTitle("課堂")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: {
                        popover.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
            
        }.sheet(isPresented: $popover) {
            NavigationView {
                List {
                    Section {
                        Text("課堂名稱")
                        TextField("課堂名稱", text: $textedit)
                    }
                    Section {
                        Button("新增") {
                            addItem()
                            textedit = ""
                            popover = false
                        }
                    }
                }
                .navigationTitle("新增一個課堂")
            }
        }
        
    }
        

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = "\(textedit)"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

