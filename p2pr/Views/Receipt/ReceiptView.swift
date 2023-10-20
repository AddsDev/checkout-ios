//
//  ReceiptView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 10/10/23.
//

import SwiftUI
import SwiftData

struct ReceiptView: View {
    var session: History
    @State var showWebView = true
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ReceiptViewModel()
    @State private var isLoading = true
    @State private var information: CheckoutInformationResponse? = nil
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView {
                    Text("title-loading")
                        .padding()
                }
            } else {
                VStack {
                    header
                    Divider()
                    date
                    resume
                    Divider()
                    if let status = information?.status.status {
                        if status == STATUS_PENDING {
                            Button("pay-checkout") {
                                showWebView = true
                            }.fullScreenCover(isPresented: $showWebView) {
                                CheckoutWebView(url: session.redirectionUrl, showWebView: $showWebView)
                                    .ignoresSafeArea()
                                    .onDisappear{
                                        Task {
                                            await viewModel.getSession(requestId: session.sessionId)
                                        }
                                    }
                            }
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10, style: .continuous) )
                .padding()
            }
            
        }.task {
            await viewModel.getSession(requestId: session.sessionId)
        }
        .onReceive(viewModel.$response) { response in
            if response != nil {
                withAnimation {
                    isLoading = false
                }
                information = response
                do {
                    session.status = response?.status.status ?? session.status
                    try modelContext.save()
                } catch _ {
                    
                }
            }
        }
        
    }
    
    func statusTransaction(status: String) -> (status: String, color: Color, icon: String) {
        switch status {
        case STATUS_OK,
            STATUS_APPROVED:
            return (NSLocalizedString("status-approved", comment: "approved"), Color.green, "checkmark.circle")
        case STATUS_FAILED,
            STATUS_REJECTED,
            STATUS_CANCEL:
                        return (NSLocalizedString("status-rejected", comment: "rejected"), Color.red, "slash.circle")
        default:
            return (NSLocalizedString("status-pending", comment: "pending"), Color.orange, "hourglass")
        }
    }
}

private extension ReceiptView {
    var header: some View {
        VStack {
            let receiptStatus = statusTransaction(status: information?.status.status ?? STATUS_PENDING)
            Image(systemName: receiptStatus.icon)
                .font(.title)
                .foregroundStyle(.white)
                .padding()
                .background(receiptStatus.color.opacity(1), in: RoundedRectangle(cornerRadius: 15.0, style: .circular))
            Text(receiptStatus.status)
                .font(.body)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("receipt-reference \(information?.request?.payment?.reference ?? "0")")
                .font(.callout)
                .padding(.top)
        }.padding()
    }
    
    var resume: some View {
        VStack {
            Text("title-total")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .textCase(.uppercase)
                .padding(.horizontal)
            LazyVStack {
                if let details = information?.request?.payment?.amount.details {
                    ItemListView(image: "truck.box", title: details[0].kind.capitalized, description: details[0].amount.formatted(.currency(code: "COP")))
                        .padding(.horizontal)
                    ItemListView(image: "basket", title: details[1].kind.capitalized, description: details[1].amount.formatted(.currency(code: "COP")))
                        .padding(.horizontal)
                }
            }
            
            if let details = information?.request?.payment?.amount.details {
                Text("receipt-total \(details.reduce(0) { $0 + $1.amount }.formatted(.currency(code: "COP")))")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
            } else {
                Text("receipt-total \(0.formatted(.currency(code: "COP")))")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
            }
            
            Text("receipt-order-detail")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .textCase(.uppercase)
                .padding(.top)
            LazyVStack {
                if let items = information?.request?.payment?.items {
                    ForEach(items, id: \.name) { item in
                        ItemListView(image: "bag", title: "\(item.name) (\(item.qty)) und", description: item.price.formatted(.currency(code: "COP")))
                            .padding(.horizontal)
                    }
                } else {
                    Text("receipt-no-results")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                }
                
            }
            .padding(.bottom)
        }
    }
    
    var date: some View {
        VStack {
            Text("receipt-date")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .textCase(.uppercase)
                .padding(.horizontal)
            if let paymentInformation = viewModel.response?.payment {
                ForEach(paymentInformation, id: \.internalReference) { payment in
                    ItemListView(image: "clock", title: payment.status.date.toDate().toString(format: DATE_DEFAULT_FORMAT))
                        .padding()
                }
            } else if let paymentStatus = viewModel.response?.status {
                ItemListView(image: "clock", title: paymentStatus.date.toDate().toString(format: DATE_DEFAULT_FORMAT))
                    .padding()
            }
        }
    }
}

#Preview {
    ReceiptView(session: History(sessionId: 123, status: "PENDING", redirectionUrl: "https:\\\\checkout-test.placetopay.com\\spa\\session\\2627760\\915e2581ccc90fa22c79fa640577b84d", detail: "1 item", buyer: "Juan Ramirez", date: Date().toString()))
        .environment(\.locale, Locale.init(identifier: "es"))
}
