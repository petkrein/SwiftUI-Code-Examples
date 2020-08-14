//
//  ContentView.swift
//  SwiftUIQuickLook
//
//  Created by Наталия Панферова on 14/08/20.
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
            VStack(spacing: 0) {
                HStack {
                    Button("Done") {
                        self.showingPreview = false
                    }
                    Spacer()
                }
                .padding()

                PreviewController(url: self.fileUrl)
            }
        }
    }
}
