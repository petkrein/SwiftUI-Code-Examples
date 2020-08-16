//
//  ContentView.swift
//  SwiftUIQuickLookInUINavigationController
//
//  Created by Наталия Панферова on 16/08/20.
//  Copyright © 2020 Наталия Панферова. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // force unwrap the optional, because the test file has to be in the bundle
    let fileUrl = Bundle.main.url(forResource: "LoremIpsum", withExtension: "pdf")!
    
    @State private var showingPreview = false
    
    var body: some View {
        Button("Preview File") {
            self.showingPreview = true
        }
        .sheet(isPresented: $showingPreview) {
            PreviewController(url: self.fileUrl, isPresented: self.$showingPreview)
        }
    }
}
