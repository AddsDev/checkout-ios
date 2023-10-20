//
//  HistoryVIew.swift
//  p2pr
//
//  Created by Adrian Ruiz on 10/10/23.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    static var tag = "HistoryViewTag"
    @Binding var path: NavigationPath
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [History]
    var body: some View {
        if history.isEmpty {
            Text("no-purchases-found")
        } else {
            List{
                ForEach(history) { item in
                    NavigationLink {
                        ReceiptView(session: item, showWebView: false)
                    } label: {
                        HStack {
                            let status = statusTransaction(status: item.status)
                            Image(systemName: status.icon)
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding(.all, 10)
                                .background(status.color.opacity(1), in: RoundedRectangle(cornerRadius: 15.0, style: .circular))
                            VStack {
                                
                                Text("shopping-id \(String(item.sessionId))")
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.body)
                                    .fontWeight(.bold)
                                Text(item.buyer)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.body)
                                Text(item.date?.toDate().toString(format: DATE_FORMAT) ?? "")
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            modelContext.delete(item)
                        } label: {
                            Label("title-delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        
    }
    
    func statusTransaction(status: String) -> (color: Color, icon: String) {
        switch status {
        case STATUS_APPROVED:
            return (Color.green, "checkmark.circle")
        case STATUS_FAILED,
            STATUS_REJECTED,
            STATUS_CANCEL:
                        return (Color.red, "slash.circle")
        default:
            return (Color.orange, "hourglass")
        }
    }
}

#Preview {
    Group {
        @State var path: NavigationPath = .init()
        HistoryView(path: $path)
            .modelContainer(for: [History.self])
            .environment(\.locale, Locale.init(identifier: "es"))
    }
}
