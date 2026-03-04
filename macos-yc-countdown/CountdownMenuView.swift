import SwiftUI

struct CountdownMenuView: View {
    @ObservedObject var viewModel: CountdownViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("YC X26 Demo Day")
                .font(.headline)

            Text(viewModel.countdownText)
                .font(.system(.title, design: .monospaced))
                .monospacedDigit()

            Divider()

            Picker("Display Mode", selection: $viewModel.displayMode) {
                Text("Show countdown in menu bar")
                    .fixedSize(horizontal: true, vertical: false)
                    .tag(DisplayMode.showInMenuBar)
                Text("Show icon only")
                    .fixedSize(horizontal: true, vertical: false)
                    .tag(DisplayMode.showInDropdown)
            }
            .pickerStyle(.radioGroup)

            Picker("Countdown Format", selection: $viewModel.countdownFormat) {
                Text("Full (123d 04h 30m 15s)")
                    .fixedSize(horizontal: true, vertical: false)
                    .tag(CountdownFormat.full)
                Text("Days only (123 days)")
                    .fixedSize(horizontal: true, vertical: false)
                    .tag(CountdownFormat.daysOnly)
                Text("Hours only (2,956 hours)")
                    .fixedSize(horizontal: true, vertical: false)
                    .tag(CountdownFormat.hoursOnly)
            }
            .pickerStyle(.radioGroup)

            Toggle("Launch at Login", isOn: Binding(
                get: { viewModel.launchAtLoginEnabled },
                set: { _ in viewModel.toggleLaunchAtLogin() }
            ))

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
        .padding()
        .frame(width: 320)
    }
}
