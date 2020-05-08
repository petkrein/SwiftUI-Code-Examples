//
//  Example code for article https://lostmoa.com/blog/ProgrammaticallyDismissDetailViewInSwiftUI/
//

import SwiftUI

struct ContentView: View {
    @State private var items = [Item(name: "Item 1"), Item(name: "Item 2"), Item(name: "Item 3")]
    @State private var selectedItemId: UUID?
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    
    // navigation link for programmatic navigation
    var navigationLink: NavigationLink<EmptyView, DetailView>? {
        guard let selectedItemId = selectedItemId,
            let selectedItem = items.first(where: {$0.id == selectedItemId}) else {
                return nil
        }
        
        return NavigationLink(
            destination: DetailView(item: selectedItem, items: $items, selectedItemId: $selectedItemId),
            tag:  selectedItemId,
            selection: $selectedItemId
        ) {
            EmptyView()
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                // hidden navigation link to control navigation programmatically
                navigationLink
                
                List {
                    ForEach(items) { item in
                        Button(action: {
                            self.selectedItemId = item.id
                        }) {
                            Text(item.name)
                        }
                        .listRowBackground(
                            
                            // if in split view, set selected background color
                            (self.selectedItemId == item.id && self.horizontalSizeClass == .regular) ?  Color.blue : Color(UIColor.systemBackground)
                        )
                        
                    }
                }
            }
            .navigationBarTitle("Items")
                
            .navigationBarItems(trailing:
                Button(action: {
                    let newItem = Item(name: "Item \(self.items.count + 1)")
                    self.items.append(newItem)
                    
                    // if in split view, programmatically navigate to newly added item
                    if self.horizontalSizeClass == .regular {
                        self.selectedItemId = newItem.id
                    }
                    
                }) {
                    Text("Add")
                }
            )
            
            NoSelectionView()
        }
    }
}

struct DetailView: View {
    let item: Item
    @Binding var items: [Item]
    @Binding var selectedItemId: UUID?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Group {
            
            // this check is needed so that when selection is nil
            // the detail view is not stuck being shown in a split view in horizontalSizeClass regular
            if selectedItemId == nil {
                NoSelectionView()
            } else {
                Text("Detail view for \(item.name).")
                    .padding()
                    .navigationBarItems(trailing:
                        HStack {
                            Button("Dismiss") {
                                
                                // calling `dismiss` will pop the detail view in horizontalSizeClass compact,
                                // but will do nothing in a split view in horizontalSizeClass regular
                                self.presentationMode.wrappedValue.dismiss()
                                
                                self.selectedItemId = nil
                            }
                            Button("Delete") {
                                self.items.removeAll { $0.id == self.item.id }
                                self.selectedItemId = nil
                            }
                        }
                )
            }
        }
    }
}

struct NoSelectionView: View {
    
    var body: some View {
        Text("Nothing Selected")
            // we need to set the navigationBarItems to an EmptyView,
            // so that when NoSelectionView is shown in the detail view after item deletion,
            // the bar items from the item detail view are not shown (otherwise they get stuck being shown)
            .navigationBarItems(trailing: EmptyView())
    }
}

struct Item: Identifiable {
    let id = UUID()
    let name: String
}
