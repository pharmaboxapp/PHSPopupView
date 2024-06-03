//
//  ScreenManager.swift of PopupView
//
//  Created by Tomasz Kurylik
//    - Twitter: https://twitter.com/tkurylik
//    - Mail: tomasz.kurylik@mijick.com
//
//  Copyright ©2023 Mijick. Licensed under MIT License.


import Observation
import SwiftUI
import Combine

// MARK: - iOS Implementation
#if os(iOS)

@Observable
class ScreenManager {
    var size: CGSize = .init()
    var safeArea: UIEdgeInsets = .init()
    private(set) var cornerRadius: CGFloat? = 0
    private(set) var animationsDisabled: Bool = false

    static let shared: ScreenManager = .init()
    private init() {}
}

private extension UIScreen {
    static var cornerRadius: CGFloat? {
        // Use a safer method if possible
        return main.value(forKey: ["Radius", "Corner", "display", "_"].reversed().joined()) as? CGFloat
    }
}

// MARK: - macOS Implementation
#elseif os(macOS)

@Observable
class ScreenManager {
    var size: CGSize = .init()
    var safeArea: NSEdgeInsets = .init()
    private(set) var cornerRadius: CGFloat? = 0
    private(set) var animationsDisabled: Bool = false
    private var subscription: [AnyCancellable] = []

    static let shared: ScreenManager = .init()
    private init() { subscribeToWindowStartResizeEvent(); subscribeToWindowEndResizeEvent() }
}

private extension ScreenManager {
    func subscribeToWindowStartResizeEvent() {
        NotificationCenter.default
            .publisher(for: NSWindow.willStartLiveResizeNotification)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in self?.animationsDisabled = true })
            .store(in: &subscription)
    }
    
    func subscribeToWindowEndResizeEvent() {
        NotificationCenter.default
            .publisher(for: NSWindow.didEndLiveResizeNotification)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in self?.animationsDisabled = false })
            .store(in: &subscription)
    }
}

// MARK: - tvOS Implementation
#elseif os(tvOS)

@Observable
class ScreenManager {
    private(set) var size: CGSize = .init()
    private(set) var safeArea: UIEdgeInsets = .init()
    private(set) var cornerRadius: CGFloat? = 0
    private(set) var animationsDisabled: Bool = false

    static let shared: ScreenManager = .init()
    private init() {}
}
#endif
