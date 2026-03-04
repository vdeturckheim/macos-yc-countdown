# YC X26 Countdown

A macOS menu bar app that counts down to YC X26 Demo Day.

![macOS](https://img.shields.io/badge/macOS-26.2%2B-blue)
![Architecture](https://img.shields.io/badge/arch-universal-green)
![License](https://img.shields.io/badge/license-MIT-blue)

The app lives in your menu bar and displays a live countdown to Demo Day. Click it to see the full breakdown (days, hours, minutes, seconds) and toggle between display modes.

## Install

### Homebrew (recommended)

```bash
brew tap vdeturckheim/tap
brew install --cask yc-x26-countdown
```

### Manual

Download the latest DMG from [GitHub Releases](https://github.com/vdeturckheim/macos-yc-countdown/releases), open it, and drag the app to `/Applications`.

## Building from source

```bash
git clone https://github.com/vdeturckheim/macos-yc-countdown.git
cd macos-yc-countdown
open macos-yc-countdown.xcodeproj
```

Build and run in Xcode (requires macOS 26.2 SDK).

## System requirements

- macOS 26.2 or later
- Universal binary (Apple Silicon + Intel)

## License

[MIT](LICENSE)
