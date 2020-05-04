//
//  Example code for article https://lostmoa.com/blog/ProgrammaticNavigationInSwiftUIListView/
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
                    let newItem = Item(name: "Item \(self.items.count + 1)")
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
    let id = UUID()
    let name: String
}
