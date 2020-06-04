//
// Example code for article: https://lostmoa.com/blog/ViewModifierForACustomHoverEffectInSwiftUI/
//

import SwiftUI

struct EditView: View {
    
    @State var isHovered = false
    
    var body: some View {
        Text("Edit")
        .padding()
        .onTapGesture {
            // some action
        }
            
        .pinkBackgroundOnHover()
    }
}

struct PinkBackgroundOnHover: ViewModifier {
    
    @State var isHovered = false
    
    func body(content: Content) -> some View {
        content
        .background(isHovered ? Color.pink : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .onHover { isHovered in
            withAnimation {
                self.isHovered = isHovered
            }
        }
    }
}

extension View {
    func pinkBackgroundOnHover() -> some View {
        self.modifier(PinkBackgroundOnHover())
    }
}
