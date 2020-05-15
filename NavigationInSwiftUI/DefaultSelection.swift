//
//  Example code for article https://lostmoa.com/blog/DefaultSelectionInSwiftUIListView/
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var items = [
        Item(id: 1, name: "Item 1"), Item(id: 2, name: "Item 2"), Item(id: 3, name: "Item 3")
    ]
    
    @State private var selectedItemId: Int?
    
    private let initialSelection: Int?
    
// Assigning a default value to selection property will break the navigation
//  @State private var selectedItemId: Int? = 1
    
// The selection set in the initializer will be ignored by the navigation.
//    init(selectedId: Int? = nil) {
//        if let selectedId = selectedId {
//            self.selectedItemId = selectedId
//        } else {
//            self.selectedItemId = self.items.first?.id
//        }
//    }
    
    init(selectedId: Int? = nil) {
        self.initialSelection = selectedId
    }
    
    
    // navigation link for programmatic navigation
    var navigationLink: NavigationLink<EmptyView, DetailView>? {
        guard let selectedItemId = selectedItemId,
            let selectedItem = items.first(where: {$0.id == selectedItemId}) else {
                return nil
        }
        
        return NavigationLink(
            destination: DetailView(item: selectedItem),
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
                    let newItemId = (self.items.last?.id ?? 0) + 1
                    let newItem = Item(id: newItemId, name: "Item \(newItemId)")
                    self.items.append(newItem)
                    
                    // if in split view, programatically navigate to newly added item
                    if self.horizontalSizeClass == .regular {
                        self.selectedItemId = newItem.id
                    }
                    
                }) {
                    Text("Add")
                }
            )
            
            NoSelectionView()
        }
        .onAppear {

            // at the moment the most reliable way to set the default selection is inside onAppear

            if let initialSelection = self.initialSelection {
                self.selectedItemId = initialSelection
            } else {
                self.selectedItemId = self.items.first?.id
            }
        }
    }
}

struct DetailView: View {
    let item: Item
    
    var body: some View {
            Text("Detail view for \(item.name).")
                .padding()
        
    }
}

struct NoSelectionView: View {
    
    var body: some View {
        Text("Nothing Selected")
    }
}

struct Item: Identifiable {
    let id: Int
    let name: String
}
