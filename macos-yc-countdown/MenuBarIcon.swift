import AppKit

enum MenuBarIcon {
    static func create() -> NSImage {
        let size: CGFloat = 18
        let image = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
            let cornerRadius: CGFloat = 3.0
            let squarePath = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)

            // Draw the Y letter cutout by compositing
            NSColor.black.setFill()
            squarePath.fill()

            // Draw the "Y" in white (will become cutout with template)
            let yPath = NSBezierPath()
            let scale = size / 32.0

            // Y shape paths scaled to our size
            // Left arm of Y
            let leftArm: [(CGFloat, CGFloat)] = [
                (7.2, 7.5), (10.0, 7.5), (16.0, 17.5), (22.0, 7.5), (24.8, 7.5), (17.6, 19.0), (17.6, 25.0), (14.4, 25.0), (14.4, 19.0)
            ]

            yPath.move(to: NSPoint(x: leftArm[0].0 * scale, y: size - leftArm[0].1 * scale))
            for i in 1..<leftArm.count {
                yPath.line(to: NSPoint(x: leftArm[i].0 * scale, y: size - leftArm[i].1 * scale))
            }
            yPath.close()

            NSGraphicsContext.current?.compositingOperation = .clear
            yPath.fill()

            return true
        }

        image.isTemplate = true
        return image
    }
}
