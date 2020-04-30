//
//  Example code for article https://lostmoa.com/blog/NavigationInSwiftUIExploringAvailableOptions/
//

import SwiftUI

struct UserDrivenNavigation: View {
    
    let items = [Item(name: "Item 1"), Item(name: "Item 2"), Item(name: "Item 3")]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        Text(item.name)
                    }
                }
            }
            .navigationBarTitle("Items")
        }
    }
}

struct ProgrammaticNavigation: View {
    @State private var items = [Item(name: "Item 1"), Item(name: "Item 2"), Item(name: "Item 3")]
    @State private var selectedItemId: UUID?
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(
                        destination: DetailView(item: item), tag: item.id, selection: self.$selectedItemId) {
                        Text(item.name)
                    }
                    .listRowBackground(
                        // only programmatically selected item will get the custom background color
                        item.id == self.selectedItemId ? Color.blue : Color(UIColor.systemBackground)
                    )
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    let newItem = Item(name: "Item \(self.items.count + 1)")
                    self.items.append(newItem)
                    
                    if self.horizontalSizeClass == .regular {
                        // runtime issues if current selection is not nil
                        self.selectedItemId = newItem.id
                    }
                    
                }) {
                    Text("Add")
                }
            )
            .navigationBarTitle("Items")
        }
    }
}

struct DetailView: View {
    let item: Item
    
    var body: some View {
        Text("Detail view for \(item.name).")
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
