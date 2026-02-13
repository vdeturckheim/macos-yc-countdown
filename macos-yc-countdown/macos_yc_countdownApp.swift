import SwiftUI

@main
struct macos_yc_countdownApp: App {
    @StateObject private var viewModel = CountdownViewModel()

    var body: some Scene {
        MenuBarExtra {
            CountdownMenuView(viewModel: viewModel)
        } label: {
            HStack(spacing: 4) {
                Image(nsImage: MenuBarIcon.create())
                if viewModel.displayMode == .showInMenuBar {
                    Text(viewModel.countdownText)
                        .monospacedDigit()
                }
            }
        }
        .menuBarExtraStyle(.window)
    }
}
