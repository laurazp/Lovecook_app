//
//  ContentView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import CoreData
import FirebaseCore
import FirebaseAuth
import Firebase
import GoogleSignIn

struct ContentView: View {
    //@State private var showOnboarding = true
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    var body: some View {
        
        //TODO: Revisar !!!!
        switch viewModel.state {
            case .signedOut: AuthView()
            case .signedIn: MainView()
            case .sessionError: errorView
                
        }
        

        //        .fullScreenCover(
        //            isPresented: $showOnboarding,
        //            content: {
        //                OnboardingTabView()
        //            })
        
        
        //        NavigationView {
        //            List {
        //                ForEach(items) { item in
        //                    NavigationLink {
        //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
        //                    } label: {
        //                        Text(item.timestamp!, formatter: itemFormatter)
        //                    }
        //                }
        //                .onDelete(perform: deleteItems)
        //            }
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    EditButton()
        //                }
        //                ToolbarItem {
        //                    Button(action: addItem) {
        //                        Label("Add Item", systemImage: "plus")
        //                    }
        //                }
        //            }
        //            Text("Select an item")
        //        }
    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(context: viewContext)
    //            newItem.timestamp = Date()
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { items[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    
    var errorView: some View {
        Text("Something went wrong...")
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#Preview {
    let viewModel = AuthenticationViewModel()
    
    return ContentView()
        .environmentObject(viewModel)
    //    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
