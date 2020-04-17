//
// Example code for article: https://lostmoa.com/blog/SwiftUIVerticalScrollViewNotUpdatingWidthWhenContentChanges/
//

import SwiftUI

struct ContentView: View {
    
    // The initial content will define the width of the ScrollView forever, if it's empty, then the ScrollView will have width 0 even when new items are added to the array unless you use any of the 3 workarounds.
    @State var items: [String] = []
    
    var body: some View {
        NavigationView {
            RegularScrollableContent(items: items)
            .navigationBarItems(trailing:
                Button("Add") {
                    self.items.append(UUID().uuidString)
                }
            )
        }
    }
}

// A simple ScrollView with content that initially has width 0, subsequently won't be displayed even when content changes.

struct RegularScrollableContent: View {
    let items: [String]
    
    var body: some View {
        ScrollView {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
        }
    }
}


// Workaround 1: Set a fixed width on the content.

struct ScrollableContentWithFixedWidth: View {
    let items: [String]
    
    var body: some View {
        ScrollView {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            .frame(width: 500)
        }
    }
}


// Workaround 2: Embed the content in a HStack with Spacers.

struct ScrollableContentInHStack: View {
    let items: [String]
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                VStack {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
                Spacer()
            }
        }
    }
}


// Workaround 3: Embed the content in a GeometryReader and dynamically calculate its width.

struct ScrollableContentInGeometryReader: View {
    let items: [String]
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                VStack {
                    ForEach(self.items, id: \.self) { item in
                        Text(item)
                    }
                }
                .frame(width: geo.size.width * 0.9)
            }
        }
    }
}
