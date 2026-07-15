import CoreText
import UIKit

enum TendiFont {
    private static let fontExtensions = ["ttf", "otf"]
    private static let fontDirectories = [nil, "Fonts", "ttf"]

    @discardableResult
    static func registerBundledFonts() -> [String] {
        let names = bundledFontURLs().compactMap(registerFont)

        #if DEBUG
        if !names.isEmpty {
            print("Registered bundled fonts: \(names.joined(separator: ", "))")
        }
        #endif

        return names
    }

    static func custom(_ postScriptName: String, size: CGFloat, fallbackWeight: UIFont.Weight = .regular) -> UIFont {
        guard !postScriptName.isEmpty, let font = UIFont(name: postScriptName, size: size) else {
            return .systemFont(ofSize: size, weight: fallbackWeight)
        }
        return font
    }

    private static func bundledFontURLs() -> [URL] {
        var urls: [URL] = []

        for fileExtension in fontExtensions {
            for directory in fontDirectories {
                urls += Bundle.main.urls(forResourcesWithExtension: fileExtension, subdirectory: directory) ?? []
            }
        }

        var seenURLs = Set<URL>()
        return urls.filter { seenURLs.insert($0).inserted }
    }

    private static func registerFont(at url: URL) -> String? {
        guard let dataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(dataProvider) else {
            return nil
        }

        let postScriptName = font.postScriptName as String? ?? url.deletingPathExtension().lastPathComponent
        var error: Unmanaged<CFError>?

        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            #if DEBUG
            if let error = error?.takeRetainedValue() {
                print("Font registration warning for \(url.lastPathComponent): \(error)")
            }
            #endif
        }

        return postScriptName
    }
}
