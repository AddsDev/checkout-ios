//
//  BuyerView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 28/09/23.
//

import SwiftUI
import SwiftData

struct BuyerView: View {
    @Binding var path: NavigationPath
    @Environment(\.modelContext) private var modelContext
    @Query private var buyers: [Buyer]
    
    var package: WelcomePackage
    
    var body: some View {
        List {
            ForEach(buyers) { buyer in
                NavigationLink {
                    ConfirmationView(package: package, buyer: buyer, path: $path)
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text(buyer.fullName())
                                .font(.body)
                                .fontWeight(.bold)
                                .fontDesign(.default)
                        }
                        Text(buyer.fullDocument())
                            .font(.caption)
                            .fontWeight(.regular)
                            .fontWidth(.standard)
                            .padding(.top, 5)
                        Text(buyer.email)
                            .font(.caption)
                            .fontWeight(.regular)
                            .fontWidth(.standard)
                        Text(buyer.mobile)
                            .font(.caption)
                            .fontWeight(.regular)
                            .fontWidth(.standard)
                        Text(buyer.address())
                            .font(.caption)
                            .fontWeight(.regular)
                            .fontWidth(.standard)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("title-buyers")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            if buyers.isEmpty {
                Buyer.options.forEach { item in
                    modelContext.insert(item)
                }
            }
        }
    }
}

#Preview {
    Group {
        @State var path: NavigationPath = .init()
        BuyerView( path: $path, package: WelcomePackage.options.first!)
            .modelContainer(for: Buyer.self, inMemory: true)
    }
}
