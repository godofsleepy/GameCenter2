//
//  CarouselView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation
import SwiftUI

struct CarouselView<Content>: View where Content: View {
    
    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content
    
    @State private var offset = CGFloat.zero
    @State private var dragging = false
    
    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing) {
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            self.content()
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                .clipped()
                        }
                    }
                    .content.offset(x: self.offset(in: geometry), y: 0)
                    .frame(width: geometry.size.width, alignment: .leading)
                }
                .clipped()
                
            }
            
            PageControl(index: $index, maxIndex: maxIndex)
        }
    }
    
    func offset(in geometry: GeometryProxy) -> CGFloat {
        return -CGFloat(self.index) * geometry.size.width
    }
    
    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255) : Color.white)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(15)
    }
}

