//
//  ItemListView.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import SwiftUI

struct ItemListView: View {
    var image: String
    var title: String
    var description: String? = nil
    var body: some View {
        HStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: image)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20))
                    .padding(.all, 10)
                    .background(.orange.opacity(1), in: RoundedRectangle(cornerRadius: 14.0, style: .circular))
            }
            .padding(.all, 2)
            
            VStack(alignment: .leading) {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .ignoresSafeArea()
                    .font(.body)
                    .foregroundStyle(.primary)
                if description != nil {
                    Text(description!)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .ignoresSafeArea()
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ItemListView(image: "cart.fill", title: "Example")
        .previewLayout(.sizeThatFits)
}
