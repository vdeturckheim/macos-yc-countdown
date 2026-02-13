import Combine
import Foundation
import SwiftUI

enum DisplayMode: String {
    case showInMenuBar
    case showInDropdown
}

enum CountdownFormat: String, CaseIterable {
    case full
    case daysOnly
    case hoursOnly
}

class CountdownViewModel: ObservableObject {
    @Published var countdownText: String = ""
    @Published var displayMode: DisplayMode {
        didSet {
            UserDefaults.standard.set(displayMode.rawValue, forKey: "displayMode")
        }
    }
    @Published var countdownFormat: CountdownFormat {
        didSet {
            UserDefaults.standard.set(countdownFormat.rawValue, forKey: "countdownFormat")
            updateCountdown()
        }
    }

    private var timer: Timer?

    private var targetDate: Date {
        var components = DateComponents()
        components.year = 2026
        components.month = 6
        components.day = 16
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: "displayMode") ?? DisplayMode.showInMenuBar.rawValue
        self.displayMode = DisplayMode(rawValue: saved) ?? .showInMenuBar
        let savedFormat = UserDefaults.standard.string(forKey: "countdownFormat") ?? CountdownFormat.full.rawValue
        self.countdownFormat = CountdownFormat(rawValue: savedFormat) ?? .full
        updateCountdown()
        startTimer()
    }

    private func startTimer() {
        timer = Timer(timeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateCountdown()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func updateCountdown() {
        let now = Date()
        let remaining = targetDate.timeIntervalSince(now)

        if remaining <= 0 {
            countdownText = "Demo Day!"
            return
        }

        let totalSeconds = Int(remaining)

        switch countdownFormat {
        case .full:
            let days = totalSeconds / 86400
            let hours = (totalSeconds % 86400) / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            countdownText = String(format: "%dd %02dh %02dm %02ds", days, hours, minutes, seconds)
        case .daysOnly:
            let days = totalSeconds / 86400
            countdownText = "\(days) days"
        case .hoursOnly:
            let totalHours = totalSeconds / 3600
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formatted = formatter.string(from: NSNumber(value: totalHours)) ?? "\(totalHours)"
            countdownText = "\(formatted) hours"
        }
    }

    deinit {
        timer?.invalidate()
    }
}
