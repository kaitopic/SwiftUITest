//
//  CollectionView.swift
//  SwiftUIText
//
//  Created by Ethan on 16/01/2025.
//

import SwiftUI

struct TwoColumnGridView: View {
    let items: [Color] = [Color(hex: 0x181A20), .blue, .green, .yellow, .orange, .purple, .pink, .red, .blue, .green, .yellow, .orange, .purple, .pink]
    
    let spacing: CGFloat = 8.0
    let edgeSpacing: CGFloat = 16.0
    let bottomPadding: CGFloat = 64.0

    var body: some View {
        GeometryReader { geometry in

            let totalWidth = geometry.size.width - (edgeSpacing * 2) - spacing
            let itemSize = totalWidth / 2
            
            ScrollView(.horizontal) {
                LazyHGrid(
                    rows: Array(repeating: GridItem(.fixed(itemSize), spacing: spacing), count: 2),
                    spacing: spacing
                ) {
                    ForEach(0..<items.count, id: \.self) { index in
                        ZStack(alignment: .bottomLeading) {
                            items[index]
                                .frame(width: itemSize, height: itemSize)
                                .cornerRadius(8)

                            HStack(spacing: 4) {

                                Image(systemName: "waveform")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(.black)

                                Text("user \(index + 100000)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .padding(5)
                            .background(
                                Color.black.opacity(0.4)
                                    .cornerRadius(4)
                            )
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                            .frame(maxWidth: itemSize - 10, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, edgeSpacing)
                .padding(.top, spacing)
                .padding(.bottom, bottomPadding)
            }
        }
    }
}


extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

#Preview {
    TwoColumnGridView()
}
