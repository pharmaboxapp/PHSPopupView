//
//  HeightReader.swift of PopupView
//
//  Created by Tomasz Kurylik
//    - Twitter: https://twitter.com/tkurylik
//    - Mail: tomasz.kurylik@mijick.com
//
//  Copyright ©2023 Mijick. Licensed under MIT License.


import SwiftUI

extension View {
    func readHeight(onChange action: @escaping (CGFloat) -> ()) -> some View {
        self.background(HeightReader())
            .onPreferenceChange(HeightPreferenceKey.self, perform: action)
    }
}

// MARK: - HeightReader
fileprivate struct HeightReader: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }
}

// MARK: - HeightPreferenceKey
fileprivate struct HeightPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
