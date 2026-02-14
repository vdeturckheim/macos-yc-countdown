import AppKit

enum MenuBarIcon {
    static func create() -> NSImage {
        let size: CGFloat = 18
        let image = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
            // Simple "Y" text-based icon
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.systemFont(ofSize: 14, weight: .semibold),
                .foregroundColor: NSColor.black,
                .paragraphStyle: paragraphStyle
            ]
            
            let text = "Y"
            let textRect = CGRect(x: 0, y: 2, width: size, height: size)
            text.draw(in: textRect, withAttributes: attributes)

            return true
        }

        image.isTemplate = true
        return image
    }
}
