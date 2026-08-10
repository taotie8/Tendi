
import Foundation
import CoreText
import UIKit

enum LLivi {
    private static let fontExtensions = ["ttf", "otf"]
    private static let fontDirectories = [nil, "Fonts", "ttf"]

    @discardableResult
    static func registerBundledFonts() -> [String] {
       var loadingo: [Any]! = [UILabel()]
    _ = loadingo
      loadingo.append(loadingo.count)

return         bundledFontURLs().compactMap(registerFont)
    }

    static func custom(_ postScriptName: String, size: CGFloat, fallbackWeight: UIFont.Weight = .regular) -> UIFont {
       var loadR: Bool = true
    var rawi: [Any]! = [92, 44, 52]
    _ = rawi
   while (!loadR) {
       var detailw: Double = 2.0
      repeat {
          var alternatee: Double = 0.0
         withUnsafeMutablePointer(to: &alternatee) { pointer in
                _ = pointer.pointee
         }
          var window_4h: String! = String(cString: [102,105,110,116,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &window_4h) { pointer in
                _ = pointer.pointee
         }
          var tap7: String! = String(cString: [111,99,99,117,112,105,101,100,0], encoding: .utf8)!
          var santiagok: [String: Any]! = [String(cString: [115,99,113,117,101,114,121,0], encoding: .utf8)!:86, String(cString: [119,101,108,99,104,0], encoding: .utf8)!:70, String(cString: [99,104,97,110,103,101,114,0], encoding: .utf8)!:88]
          var rightN: Bool = true
         withUnsafeMutablePointer(to: &rightN) { pointer in
    
         }
         detailw /= Swift.max(Double(3), 5)
         alternatee += (Double(Int(detailw > 343688985.0 || detailw < -343688985.0 ? 27.0 : detailw) << (Swift.min(1, labs((rightN ? 2 : 3))))))
         window_4h = "\((window_4h == (String(cString:[87,0], encoding: .utf8)!) ? window_4h.count : santiagok.count))"
         tap7.append("\(window_4h.count)")
         santiagok["\(rightN)"] = ((rightN ? 2 : 3) / (Swift.max(Int(alternatee > 268533055.0 || alternatee < -268533055.0 ? 58.0 : alternatee), 7)))
         if 1432377.0 == detailw {
            break
         }
      } while (1432377.0 == detailw) && ((detailw * 3.24) <= 4.93 && (detailw * detailw) <= 3.24)
         detailw += (Double(Int(detailw > 263062096.0 || detailw < -263062096.0 ? 78.0 : detailw)))
      if detailw < 1.6 {
         detailw -= (Double(Int(detailw > 197147718.0 || detailw < -197147718.0 ? 94.0 : detailw)))
      }
      loadR = rawi.count < 95 && loadR
      break
   }

        guard !postScriptName.isEmpty, let font = UIFont(name: postScriptName, size: size) else {
            return .systemFont(ofSize: size, weight: fallbackWeight)
        }
        return font
      loadR = (rawi.contains { $0 as? Bool == loadR })
    }

    private static func bundledFontURLs() -> [URL] {
       var commentg: [Any]! = [29, 8, 55]
       var scriptW: String! = String(cString: [114,101,116,114,97,110,115,109,105,115,115,105,111,110,0], encoding: .utf8)!
       var monevayoanaT: Bool = true
      withUnsafeMutablePointer(to: &monevayoanaT) { pointer in
             _ = pointer.pointee
      }
       var blockedi: [String: Any]! = [String(cString: [99,101,110,116,101,114,101,100,0], encoding: .utf8)!:String(cString: [109,118,101,120,0], encoding: .utf8)!]
      withUnsafeMutablePointer(to: &blockedi) { pointer in
             _ = pointer.pointee
      }
      if !monevayoanaT {
         monevayoanaT = blockedi.values.count > 71
      }
      while (scriptW.count < 2) {
          var actionQ: [Any]! = [79, 38, 74]
          _ = actionQ
         monevayoanaT = 71 == blockedi.count || 71 == actionQ.count
         break
      }
         monevayoanaT = scriptW.count < 40
      if monevayoanaT {
         blockedi = ["\(monevayoanaT)": scriptW.count << (Swift.min(labs(1), 3))]
      }
      repeat {
          var rootP: Int = 3
          var looperB: Double = 2.0
         monevayoanaT = 98 <= scriptW.count
         rootP -= (3 & Int(looperB > 387098176.0 || looperB < -387098176.0 ? 26.0 : looperB))
         looperB /= Swift.max(5, Double(scriptW.count))
         if monevayoanaT ? !monevayoanaT : monevayoanaT {
            break
         }
      } while (monevayoanaT ? !monevayoanaT : monevayoanaT) && (!monevayoanaT)
      if !scriptW.contains("\(monevayoanaT)") {
         monevayoanaT = blockedi.values.count <= 34
      }
          var clickl: String! = String(cString: [101,120,105,115,116,115,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &clickl) { pointer in
    
         }
          var close7: Float = 1.0
         scriptW = "\(((monevayoanaT ? 3 : 1) / 1))"
         clickl.append("\((clickl == (String(cString:[86,0], encoding: .utf8)!) ? clickl.count : Int(close7 > 265421801.0 || close7 < -265421801.0 ? 62.0 : close7)))")
         close7 /= Swift.max(4, Float(scriptW.count))
         monevayoanaT = monevayoanaT || scriptW.count < 64
      if 2 < scriptW.count || monevayoanaT {
         monevayoanaT = (((!monevayoanaT ? blockedi.values.count : 75) | blockedi.values.count) > 92)
      }
      commentg.append(commentg.count)

        var chat: [URL] = []

        for fileExtension in fontExtensions {
            for directory in fontDirectories {
                chat += Bundle.main.urls(forResourcesWithExtension: fileExtension, subdirectory: directory) ?? []
            }
        }

        var row = Set<URL>()
        return chat.filter { row.insert($0).inserted }
    }

    private static func registerFont(at url: URL) -> String? {
       var fileK: Bool = false
    _ = fileK
   if !fileK || fileK {
       var mediaE: String! = String(cString: [112,97,115,116,101,108,0], encoding: .utf8)!
       _ = mediaE
       var c_tagU: [String: Any]! = [String(cString: [113,117,97,100,114,0], encoding: .utf8)!:88, String(cString: [107,105,99,107,0], encoding: .utf8)!:93]
       var taskj: String! = String(cString: [99,108,105,99,107,0], encoding: .utf8)!
      withUnsafeMutablePointer(to: &taskj) { pointer in
             _ = pointer.pointee
      }
       var createdX: Double = 1.0
       var typesU: Double = 1.0
      while (3 <= (1 * taskj.count) || (taskj.count / 1) <= 3) {
         taskj = "\((Int(typesU > 124463073.0 || typesU < -124463073.0 ? 92.0 : typesU) - c_tagU.keys.count))"
         break
      }
         c_tagU = ["\(c_tagU.values.count)": taskj.count * 2]
         taskj.append("\(taskj.count)")
         createdX *= Double(c_tagU.count)
      repeat {
         createdX -= Double(1)
         if createdX == 1034405.0 {
            break
         }
      } while (1 == (3 << (Swift.min(3, taskj.count))) || (3 % (Swift.max(4, taskj.count))) == 5) && (createdX == 1034405.0)
          var itemc: [String: Any]! = [String(cString: [107,105,116,116,121,0], encoding: .utf8)!:String(cString: [104,121,115,99,97,108,101,0], encoding: .utf8)!, String(cString: [116,98,108,101,110,100,0], encoding: .utf8)!:String(cString: [117,116,118,105,100,101,111,0], encoding: .utf8)!]
         typesU += Double(itemc.keys.count)
         taskj = "\((Int(typesU > 347223751.0 || typesU < -347223751.0 ? 92.0 : typesU) | taskj.count))"
         mediaE.append("\(1 | taskj.count)")
         mediaE = "\((Int(typesU > 91681629.0 || typesU < -91681629.0 ? 2.0 : typesU) + 1))"
       var winsofmiA: Double = 1.0
      withUnsafeMutablePointer(to: &winsofmiA) { pointer in
             _ = pointer.pointee
      }
       var modityw: [String: Any]! = [String(cString: [117,110,114,101,115,101,114,118,101,100,0], encoding: .utf8)!:49, String(cString: [99,111,109,112,108,101,116,101,0], encoding: .utf8)!:11]
       var dallarZ: [String: Any]! = [String(cString: [101,118,101,114,121,119,104,101,114,101,0], encoding: .utf8)!:94, String(cString: [108,105,99,101,110,115,101,115,0], encoding: .utf8)!:50]
       _ = dallarZ
         winsofmiA -= Double(c_tagU.values.count)
          var subjectJ: String! = String(cString: [104,97,108,108,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &subjectJ) { pointer in
                _ = pointer.pointee
         }
          var gradientv: [Any]! = [93, 23, 38]
          var liviN: Double = 4.0
         winsofmiA -= (Double(Int(typesU > 62777068.0 || typesU < -62777068.0 ? 97.0 : typesU)))
         subjectJ = "\(gradientv.count / (Swift.max(1, 1)))"
         gradientv = [c_tagU.keys.count]
         liviN -= Double(3)
      while (modityw["\(dallarZ.keys.count)"] != nil) {
          var screen1: [Any]! = [String(cString: [122,117,108,117,0], encoding: .utf8)!, String(cString: [97,115,100,107,0], encoding: .utf8)!, String(cString: [109,101,100,105,97,115,0], encoding: .utf8)!]
          var constraintsy: [String: Any]! = [String(cString: [112,114,105,118,97,99,121,0], encoding: .utf8)!:String(cString: [108,111,111,107,117,112,0], encoding: .utf8)!, String(cString: [109,105,100,105,0], encoding: .utf8)!:String(cString: [109,106,112,101,103,101,110,99,0], encoding: .utf8)!]
          var indicatorb: Int = 3
         withUnsafeMutablePointer(to: &indicatorb) { pointer in
    
         }
         modityw = ["\(constraintsy.count)": 3]
         screen1 = [mediaE.count]
         indicatorb ^= constraintsy.keys.count << (Swift.min(taskj.count, 3))
         break
      }
      repeat {
         modityw = ["\(modityw.values.count)": modityw.values.count]
         if modityw.count == 2073528 {
            break
         }
      } while (modityw["\(createdX)"] == nil) && (modityw.count == 2073528)
      fileK = 52 < c_tagU.values.count
   }

        guard let dataProvider = CGDataProvider(url: url as CFURL),
              let input = CGFont(dataProvider) else {
            return nil
        }

        let text = input.postScriptName as String? ?? url.deletingPathExtension().lastPathComponent
        var completes: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(input, &completes)

        return text
    }
}
