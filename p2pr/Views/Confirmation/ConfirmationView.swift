//
//  ConfirmationView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import SwiftUI

struct ConfirmationView: View {
    
    var package: WelcomePackage
    var buyer: Buyer
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ConfirmationViewModel()
    @Binding var path: NavigationPath
    @State private var isLoading = false
    @State private var history: History? = nil
    
    var body: some View {
        ScrollView {
            if history != nil {
                ReceiptView(session: history!)
            } else {
                VStack {
                    detail
                    Spacer()
                    shippingAddress
                        .padding(.top)
                    Spacer()
                    order
                        .padding(.top)
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .navigationTitle("title-confirmation")
                .navigationBarTitleDisplayMode(.inline)
                Button {
                    isLoading.toggle()
                    Task {
                        await viewModel.createSession(package: package, buyer: buyer)
                        isLoading.toggle()
                    }
                } label: {
                    HStack(alignment: .center) {
                        if isLoading {
                            ProgressView()
                                .padding()
                        }
                        else if viewModel.error !=  nil {
                            Text(viewModel.error!)
                                .padding()
                        } else {
                            Text("title-buy-now")
                                .padding()
                        }
                    }
                }
                .disabled(isLoading)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
            }
        }
        .onReceive(viewModel.$response) { response in
            if let response = response {
                history = History(
                    sessionId: response.requestId ?? 0,
                    status: response.status.status,
                    redirectionUrl: response.processUrl ?? "",
                    detail: package.detail,
                    buyer: "\(buyer.name) \(buyer.surname)",
                    date: response.status.date
                )
                modelContext.insert(history!)
            }
        }
    }
}

#Preview {
    Group {
        @State var path: NavigationPath = .init()
        ConfirmationView(package: .options.first!, buyer: .options.first!, path: $path)
    }
}

private extension ConfirmationView {
    var detail: some View {
        VStack(alignment: .center) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(.orange.opacity(1), in: RoundedRectangle(cornerRadius: 14.0, style: .circular))
            }
            .padding(.vertical)
            
            Text("confirmation-pruchase-detail")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            Text(package.detail)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
    var shippingAddress: some View {
        Section(content: {
            VStack {
                ItemListView(image: "person.fill", title: buyer.fullName())
                Divider()
                ItemListView(image: "person.text.rectangle.fill", title: buyer.fullDocument())
                Divider()
                ItemListView(image: "at", title: buyer.email)
                Divider()
                ItemListView(image: "phone", title: buyer.phone)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            
        }, header: {
            Text("confirmation-address")
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .textCase(.uppercase)
                .padding(.horizontal)
        })
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    var order: some View {
        VStack {
            Text("confirmation-order")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .textCase(.uppercase)
                .padding(.horizontal)
            LazyVStack {
                ForEach(Category.allCases) { category in
                    let sorted = package.sortedItems(category: category)
                    Section(content: {
                        ForEach(sorted) { $item in
                            ItemListView(image: "bag", title: "\(item.name) (\(item.qty)) und", description: item.price.formatted(.currency(code: "COP")))
                        }
                    }, header: {
                        if !sorted.isEmpty {
                            Text(category.name)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                                .textCase(.uppercase)
                                .padding(.top, 2)
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text("title-total")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .textCase(.uppercase)
                .padding(.horizontal)
            
            LazyVStack {
                ItemListView(image: "truck.box", title: NSLocalizedString("title-shipping", comment: "Shipping"), description: WelcomePackage.standardShipping.formatted(.currency(code: "COP")))
                ItemListView(image: "basket", title: NSLocalizedString("title-sub-total", comment: "Subtotal"), description: package.subTotal().formatted(.currency(code: "COP")))
                Text("receipt-total \((WelcomePackage.standardShipping + package.subTotal()).formatted(.currency(code: "COP")))")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            
        }
    }
}
