import AppKit

struct IconTarget {
  let path: String
  let size: Int
}

let root = FileManager.default.currentDirectoryPath

let targets: [IconTarget] = [
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png", size: 20),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png", size: 40),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png", size: 60),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png", size: 29),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png", size: 58),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png", size: 87),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png", size: 40),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png", size: 80),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png", size: 120),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png", size: 120),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png", size: 180),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png", size: 76),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png", size: 152),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png", size: 167),
  IconTarget(path: "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png", size: 1024),
  IconTarget(path: "android/app/src/main/res/mipmap-mdpi/ic_launcher.png", size: 48),
  IconTarget(path: "android/app/src/main/res/mipmap-hdpi/ic_launcher.png", size: 72),
  IconTarget(path: "android/app/src/main/res/mipmap-xhdpi/ic_launcher.png", size: 96),
  IconTarget(path: "android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png", size: 144),
  IconTarget(path: "android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png", size: 192),
  IconTarget(path: "web/favicon.png", size: 32),
  IconTarget(path: "web/icons/Icon-192.png", size: 192),
  IconTarget(path: "web/icons/Icon-512.png", size: 512),
  IconTarget(path: "web/icons/Icon-maskable-192.png", size: 192),
  IconTarget(path: "web/icons/Icon-maskable-512.png", size: 512),
  IconTarget(path: "assets/app_icon/cuida_mais_app_icon.png", size: 1024),
]

func color(_ hex: Int, alpha: CGFloat = 1) -> NSColor {
  NSColor(
    calibratedRed: CGFloat((hex >> 16) & 0xff) / 255,
    green: CGFloat((hex >> 8) & 0xff) / 255,
    blue: CGFloat(hex & 0xff) / 255,
    alpha: alpha
  )
}

func drawRoundedRect(_ rect: CGRect, radius: CGFloat, fill: NSColor) {
  fill.setFill()
  NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius).fill()
}

func drawText(_ text: String, rect: CGRect, font: NSFont, color: NSColor, kern: CGFloat = 0, alignment: NSTextAlignment = .center) {
  let paragraph = NSMutableParagraphStyle()
  paragraph.alignment = alignment
  let attributes: [NSAttributedString.Key: Any] = [
    .font: font,
    .foregroundColor: color,
    .kern: kern,
    .paragraphStyle: paragraph,
  ]
  text.draw(in: rect, withAttributes: attributes)
}

func makeIcon(size: Int) throws -> NSBitmapImageRep {
  guard
    let bitmap = NSBitmapImageRep(
      bitmapDataPlanes: nil,
      pixelsWide: size,
      pixelsHigh: size,
      bitsPerSample: 8,
      samplesPerPixel: 4,
      hasAlpha: true,
      isPlanar: false,
      colorSpaceName: .deviceRGB,
      bytesPerRow: 0,
      bitsPerPixel: 0
    ),
    let context = NSGraphicsContext(bitmapImageRep: bitmap)
  else {
    throw NSError(domain: "IconGenerator", code: 1)
  }

  NSGraphicsContext.saveGraphicsState()
  NSGraphicsContext.current = context
  context.cgContext.setShouldAntialias(true)

  let scale = CGFloat(size) / 1024
  func s(_ value: CGFloat) -> CGFloat { value * scale }
  func r(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    CGRect(x: s(x), y: s(y), width: s(width), height: s(height))
  }

  let fullRect = r(0, 0, 1024, 1024)
  NSGradient(colors: [
    color(0xFFFFFF),
    color(0xF3FAF6),
  ])!.draw(in: fullRect, angle: -28)

  NSGraphicsContext.current?.saveGraphicsState()
  let wave = NSBezierPath()
  wave.move(to: NSPoint(x: s(430), y: s(0)))
  wave.curve(
    to: NSPoint(x: s(1024), y: s(355)),
    controlPoint1: NSPoint(x: s(580), y: s(160)),
    controlPoint2: NSPoint(x: s(800), y: s(92))
  )
  wave.line(to: NSPoint(x: s(1024), y: s(0)))
  wave.close()
  let waveGradient = NSGradient(colors: [
    color(0xBFDCCD, alpha: 0.82),
    color(0x8FC0A6, alpha: 0.36),
  ])!
  waveGradient.draw(in: wave, angle: 32)
  NSGraphicsContext.current?.restoreGraphicsState()

  let markCenter = NSPoint(x: s(512), y: s(610))
  let crescent = NSBezierPath()
  crescent.appendArc(
    withCenter: markCenter,
    radius: s(190),
    startAngle: 48,
    endAngle: 306,
    clockwise: false
  )
  color(0x23664C).setStroke()
  crescent.lineWidth = s(78)
  crescent.lineCapStyle = .round
  crescent.stroke()

  let hand = NSBezierPath()
  hand.move(to: NSPoint(x: s(405), y: s(445)))
  hand.curve(
    to: NSPoint(x: s(663), y: s(555)),
    controlPoint1: NSPoint(x: s(490), y: s(405)),
    controlPoint2: NSPoint(x: s(598), y: s(455))
  )
  hand.curve(
    to: NSPoint(x: s(710), y: s(500)),
    controlPoint1: NSPoint(x: s(700), y: s(617)),
    controlPoint2: NSPoint(x: s(730), y: s(565))
  )
  hand.curve(
    to: NSPoint(x: s(555), y: s(365)),
    controlPoint1: NSPoint(x: s(686), y: s(402)),
    controlPoint2: NSPoint(x: s(620), y: s(362))
  )
  hand.curve(
    to: NSPoint(x: s(405), y: s(445)),
    controlPoint1: NSPoint(x: s(486), y: s(368)),
    controlPoint2: NSPoint(x: s(432), y: s(402))
  )
  hand.close()
  NSGradient(colors: [color(0xA7D5BB), color(0x4CA27D)])!.draw(in: hand, angle: -40)

  let plus = NSBezierPath()
  plus.appendRoundedRect(r(481, 535, 76, 190), xRadius: s(14), yRadius: s(14))
  plus.appendRoundedRect(r(424, 592, 190, 76), xRadius: s(14), yRadius: s(14))
  NSGradient(colors: [color(0x78AE94), color(0x2F7A5F)])!.draw(in: plus, angle: -55)

  drawText(
    "Cuida+",
    rect: r(182, 210, 660, 160),
    font: NSFont.systemFont(ofSize: s(138), weight: .heavy),
    color: color(0x195F48)
  )
  drawText(
    "PRIMEIROS SOCORROS",
    rect: r(256, 142, 512, 72),
    font: NSFont.systemFont(ofSize: s(24), weight: .bold),
    color: color(0x2F7A5F),
    kern: s(12)
  )

  color(0x2F7A5F, alpha: 0.72).setStroke()
  let leftLine = NSBezierPath()
  leftLine.move(to: NSPoint(x: s(198), y: s(168)))
  leftLine.line(to: NSPoint(x: s(242), y: s(168)))
  leftLine.lineWidth = s(2)
  leftLine.stroke()
  let rightLine = NSBezierPath()
  rightLine.move(to: NSPoint(x: s(782), y: s(168)))
  rightLine.line(to: NSPoint(x: s(826), y: s(168)))
  rightLine.lineWidth = s(2)
  rightLine.stroke()

  NSGraphicsContext.restoreGraphicsState()
  return bitmap
}

func writePNG(_ bitmap: NSBitmapImageRep, to path: String) throws {
  guard let data = bitmap.representation(using: .png, properties: [:]) else {
    throw NSError(domain: "IconGenerator", code: 1)
  }

  let url = URL(fileURLWithPath: root).appendingPathComponent(path)
  try FileManager.default.createDirectory(
    at: url.deletingLastPathComponent(),
    withIntermediateDirectories: true
  )
  try data.write(to: url)
}

for target in targets {
  try writePNG(makeIcon(size: target.size), to: target.path)
  print("Wrote \(target.path)")
}
