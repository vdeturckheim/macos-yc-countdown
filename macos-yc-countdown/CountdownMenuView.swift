import SwiftUI

struct CountdownMenuView: View {
    @ObservedObject var viewModel: CountdownViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("YC S26 Demo Day")
                .font(.headline)

            Text(viewModel.countdownText)
                .font(.system(.title, design: .monospaced))
                .monospacedDigit()

            Divider()

            Picker("Display Mode", selection: $viewModel.displayMode) {
                Text("Show countdown in menu bar").tag(DisplayMode.showInMenuBar)
                Text("Show icon only").tag(DisplayMode.showInDropdown)
            }
            .pickerStyle(.radioGroup)

            Picker("Countdown Format", selection: $viewModel.countdownFormat) {
                Text("Full (123d 04h 30m 15s)").tag(CountdownFormat.full)
                Text("Days only (123 days)").tag(CountdownFormat.daysOnly)
                Text("Hours only (2,956 hours)").tag(CountdownFormat.hoursOnly)
            }
            .pickerStyle(.radioGroup)

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
        .padding()
        .frame(width: 280)
    }
}
