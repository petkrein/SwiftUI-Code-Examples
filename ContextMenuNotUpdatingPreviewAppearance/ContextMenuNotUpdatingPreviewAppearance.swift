/*
 In SwiftUI the ContextMenu seems to be taking a screenshot of the view before been shown. Then when the appearance of the view changes, the ContextMenu doesn't update that screenshot.
 
 In the example below if we use the ViewWithContextMenuProblem and trigger the ContextMenu in dark mode, then switch to light mode and trigger the ContextMenu again, the preview of the ContextMenu will still be dark.
 
 It's possible to fix this particular example by observing the colorScheme environment variable and setting it as the id of the ContextMenu. This will cause the ContextMenu to be recreated when the colorScheme changes.
 
 This example is applicable to any other state changes that can influence the ContextMenu preview appearance. The fix would be to construct the id of the ContextMenu by combining all the changes that affect it.
*/



import SwiftUI

struct ViewWithContextMenuProblem: View {
    
    var body: some View {
        Text("SwiftUI Popover")
            .padding()
            .background(Color.secondarySystemBackground)
            
            .contextMenu {
                Button(action: {}) {
                    Text("Copy")
                    Image(systemName: "doc.on.doc")
                }
            }
    }
}

struct ViewWithFixedContextMenuProblem: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("SwiftUI Popover")
            .padding()
            .background(Color.secondarySystemBackground)
            
            .contextMenu {
                Button(action: {}) {
                    Text("Copy")
                    Image(systemName: "doc.on.doc")
                }
            }
            .id(colorScheme)
        
    }
}
