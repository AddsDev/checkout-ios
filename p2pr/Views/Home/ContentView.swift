//
//  ContentView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 28/09/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    static let tag = "ContentView"
    
    
    @Environment(\.modelContext) private var modelContext
    @Query private var packages: [WelcomePackage]
    
    @State var path: NavigationPath = .init()
    @State private var isPresented = false

    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                home.tabItem {
                    Image(systemName: "house")
                    Text("title-home")
                }
                history.tabItem {
                    Image(systemName: "list.bullet")
                    Text("title-history")
                }
                
            }
        }
    }

}

private extension ContentView {
    
    var history: some View {
        HistoryView(path: $path)
    }
    
    var home: some View {
        List {
            ForEach(packages) { item in
                NavigationLink(value: item){
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "cart")
                            Text(item.title)
                                .font(.body)
                                .fontWeight(.bold)
                                .fontDesign(.default)
                        }
                        Text(item.detail)
                            .font(.caption)
                            .fontWeight(.regular)
                            .fontWidth(.standard)
                            .padding(.top, 4)
                    }
                    
                }
            }
        }
        .onAppear {
            if packages.isEmpty {
                WelcomePackage.options.forEach { item in
                    modelContext.insert(item)
                }
            }
        }
        .navigationTitle("title-package")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: WelcomePackage.self) { package in
            BuyerView(path: $path, package: package)
        }
        .navigationDestination(for: String.self) { tag in
            switch tag {
            case HistoryView.tag: HistoryView(path: $path)
            default: ContentView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WelcomePackage.self, inMemory: true)
}
