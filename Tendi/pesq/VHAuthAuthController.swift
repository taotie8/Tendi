
import Foundation

import UIKit

class VHAuthAuthController: UITabBarController {
var description_xRawScreenList: [Any]?
var packageCancelStr: String?
private var itemsNamesFileDictionary: [String: Any]?
var loadingMax: Float? = 0.0


    
    private struct IVideoTabbarItem {
var cell_flag: Int? = 0
var generatorMin: Double? = 0



        let viewController: UIViewController
        let normalImageName: String
        let selectedImageName: String
    }
    
    private let customTabBarView = UIView()
    private var tabButtons: [UIButton] = []
    private var tabButtonWidthConstraints: [NSLayoutConstraint] = []
    
    private let customTabBarHeight: CGFloat = 87
    private let normalItemWidth: CGFloat = 64
    private let selectedItemWidth: CGFloat = 122
    private let itemSpacing: CGFloat = 8
    private var isCustomTabBarHidden = false

@discardableResult
 func playErrorUserScrollView() -> UIScrollView! {
    var presenterD: String! = String(cString: [100,111,99,117,109,101,110,116,115,0], encoding: .utf8)!
    var controllersy: [Any]! = [91, 57]
   if 2 < (controllersy.count ^ presenterD.count) && (controllersy.count ^ presenterD.count) < 2 {
      controllersy.append(controllersy.count)
   }
     let followingPopup: UIImageView! = UIImageView(image:UIImage(named:String(cString: [115,105,109,117,108,97,116,101,0], encoding: .utf8)!), highlightedImage:UIImage(named:String(cString: [112,114,101,115,117,98,109,105,116,0], encoding: .utf8)!))
     let tabbarClose: String! = String(cString: [105,99,111,110,0], encoding: .utf8)!
     let navigationModity: UIImageView! = UIImageView(frame:CGRect.zero)
    var interpolatorsRedelegate:UIScrollView! = UIScrollView(frame:CGRect(x: 220, y: 361, width: 0, height: 0))
    interpolatorsRedelegate.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    interpolatorsRedelegate.alwaysBounceVertical = false
    interpolatorsRedelegate.alwaysBounceHorizontal = true
    interpolatorsRedelegate.showsVerticalScrollIndicator = false
    interpolatorsRedelegate.showsHorizontalScrollIndicator = true
    interpolatorsRedelegate.delegate = nil
    interpolatorsRedelegate.alpha = 0.1;
    interpolatorsRedelegate.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    interpolatorsRedelegate.frame = CGRect(x: 132, y: 16, width: 0, height: 0)
    followingPopup.alpha = 1.0;
    followingPopup.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    followingPopup.frame = CGRect(x: 302, y: 143, width: 0, height: 0)
    followingPopup.animationRepeatCount = 9
    followingPopup.image = UIImage(named:String(cString: [97,110,97,105,115,98,98,110,0], encoding: .utf8)!)
    followingPopup.contentMode = .scaleAspectFit
    
    interpolatorsRedelegate.addSubview(followingPopup)
    navigationModity.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    navigationModity.alpha = 0.2
    navigationModity.frame = CGRect(x: 170, y: 290, width: 0, height: 0)
    navigationModity.animationRepeatCount = 0
    navigationModity.image = UIImage(named:String(cString: [99,104,97,116,0], encoding: .utf8)!)
    navigationModity.contentMode = .scaleAspectFit
    
    interpolatorsRedelegate.addSubview(navigationModity)

    
    return interpolatorsRedelegate

}





    override func viewDidLoad() {

         let contextconfigRan: UIScrollView! = playErrorUserScrollView()

      if contextconfigRan != nil {
          let contextconfigRan_tag = contextconfigRan.tag
          self.view.addSubview(contextconfigRan)
      }
      else {
          print("contextconfigRan is nil")      }

_ = contextconfigRan


       var right9: Float = 5.0
      right9 /= Swift.max((Float(2 & Int(right9 > 24178688.0 || right9 < -24178688.0 ? 61.0 : right9))), 4)

        super.viewDidLoad()

        let value = [
            IVideoTabbarItem(viewController: XChatAgreementController(), normalImageName: "emptyCustom", selectedImageName: "commMessPreview"),
            IVideoTabbarItem(viewController: PHeaderController(), normalImageName: "playProcessing", selectedImageName: "recommendationVerticalScript"),
            IVideoTabbarItem(viewController: POELocalController(), normalImageName: "zonsLooper", selectedImageName: "fileFollowing"),
            IVideoTabbarItem(viewController: GSessionBaseController(), normalImageName: "purchaseRemove", selectedImageName: "unlockSubdirectory")
        ]
        
        viewControllers = value.map { makeRootViewController(for: $0.viewController) }
        tabBar.isHidden = true
        setupCustomTabBar(with: value)
        updateTabBarSelection()
    }
    
    override func viewDidLayoutSubviews() {
       var zonsV: Double = 2.0
   repeat {
       var sharedR: String! = String(cString: [113,117,97,110,116,0], encoding: .utf8)!
       _ = sharedR
       var constraintsJ: [Any]! = [80, 89, 14]
      withUnsafeMutablePointer(to: &constraintsJ) { pointer in
    
      }
       var sender1: Double = 0.0
          var reportR: String! = String(cString: [97,99,114,111,115,115,102,97,100,101,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &reportR) { pointer in
    
         }
          var persistedK: String! = String(cString: [99,104,97,110,103,101,100,0], encoding: .utf8)!
          var pagei: Double = 5.0
          _ = pagei
         sharedR.append("\(1)")
         reportR = "\(reportR.count + persistedK.count)"
         persistedK = "\(((String(cString:[105,0], encoding: .utf8)!) == sharedR ? Int(sender1 > 175274747.0 || sender1 < -175274747.0 ? 75.0 : sender1) : sharedR.count))"
         pagei -= (Double(2 + Int(sender1 > 294670161.0 || sender1 < -294670161.0 ? 43.0 : sender1)))
          var fontM: Float = 1.0
         constraintsJ.append(3)
         fontM *= Float(1)
          var headerZ: [Any]! = [97, 91, 57]
          var resourceb: Double = 3.0
         constraintsJ = [(Int(resourceb > 237017926.0 || resourceb < -237017926.0 ? 5.0 : resourceb) >> (Swift.min(constraintsJ.count, 1)))]
         headerZ.append(constraintsJ.count)
      if 4.1 == (sender1 - 5.70) && (5.70 - sender1) == 2.18 {
          var albumk: [String: Any]! = [String(cString: [115,101,99,117,114,101,100,0], encoding: .utf8)!:53, String(cString: [114,116,112,112,114,111,116,111,0], encoding: .utf8)!:51, String(cString: [115,101,103,117,101,0], encoding: .utf8)!:81]
          _ = albumk
          var namesy: Double = 2.0
          var auth8: [String: Any]! = [String(cString: [112,108,97,99,101,115,0], encoding: .utf8)!:String(cString: [100,105,115,101,109,118,111,119,101,108,101,100,0], encoding: .utf8)!, String(cString: [115,110,97,112,115,104,111,116,115,0], encoding: .utf8)!:String(cString: [115,105,109,112,108,101,0], encoding: .utf8)!, String(cString: [102,101,116,99,104,101,114,115,0], encoding: .utf8)!:String(cString: [115,104,105,109,0], encoding: .utf8)!]
          var passwordr: [String: Any]! = [String(cString: [109,97,110,117,97,108,0], encoding: .utf8)!:86.0]
         withUnsafeMutablePointer(to: &passwordr) { pointer in
                _ = pointer.pointee
         }
          var pagem: String! = String(cString: [99,104,111,109,112,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &pagem) { pointer in
                _ = pointer.pointee
         }
         constraintsJ.append(constraintsJ.count + 2)
         albumk["\(sender1)"] = albumk.values.count
         namesy /= Swift.max(Double(albumk.count << (Swift.min(3, auth8.values.count))), 3)
         auth8 = ["\(passwordr.keys.count)": constraintsJ.count << (Swift.min(2, passwordr.values.count))]
         pagem = "\((sharedR == (String(cString:[102,0], encoding: .utf8)!) ? sharedR.count : auth8.count))"
      }
      while (constraintsJ.count > sharedR.count) {
         constraintsJ.append((sharedR == (String(cString:[57,0], encoding: .utf8)!) ? constraintsJ.count : sharedR.count))
         break
      }
      for _ in 0 ..< 3 {
          var loginV: String! = String(cString: [99,111,100,101,99,105,100,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &loginV) { pointer in
    
         }
          var recommendationA: String! = String(cString: [105,110,116,114,111,0], encoding: .utf8)!
         sharedR = "\(2)"
         loginV = "\((Int(sender1 > 318362939.0 || sender1 < -318362939.0 ? 9.0 : sender1) << (Swift.min(loginV.count, 1))))"
         recommendationA.append("\(sharedR.count)")
      }
         sender1 -= (Double(Int(sender1 > 136520270.0 || sender1 < -136520270.0 ? 10.0 : sender1) << (Swift.min(1, labs(1)))))
          var anaisbbnn: String! = String(cString: [114,111,117,116,105,110,115,0], encoding: .utf8)!
          _ = anaisbbnn
          var coverT: [Any]! = [29, 31, 99]
         sharedR = "\(2 - sharedR.count)"
         anaisbbnn.append("\((Int(sender1 > 226944905.0 || sender1 < -226944905.0 ? 44.0 : sender1) % (Swift.max(constraintsJ.count, 6))))")
         coverT.append(anaisbbnn.count)
          var nowq: Int = 0
         withUnsafeMutablePointer(to: &nowq) { pointer in
                _ = pointer.pointee
         }
          var usel: String! = String(cString: [97,110,105,109,97,108,115,0], encoding: .utf8)!
          var delegate_fza: Int = 2
          _ = delegate_fza
         constraintsJ = [1 & delegate_fza]
         nowq ^= delegate_fza
         usel.append("\(3)")
      zonsV /= Swift.max((Double(Int(sender1 > 140750337.0 || sender1 < -140750337.0 ? 73.0 : sender1) / (Swift.max(1, constraintsJ.count)))), 3)
      if 672033.0 == zonsV {
         break
      }
   } while ((Double(zonsV - Double(3))) == 4.83) && (672033.0 == zonsV)

        super.viewDidLayoutSubviews()
        tabBar.isHidden = true
        view.bringSubviewToFront(customTabBarView)
    }

@discardableResult
 func resignNeverCrossKitTableView(sessionCollection: String!, editLaunch: [String: Any]!) -> UITableView! {
    var jacobbradshawo: Double = 3.0
    var addedE: String! = String(cString: [112,114,111,99,97,109,112,0], encoding: .utf8)!
    _ = addedE
   while ((2.88 - jacobbradshawo) >= 4.85 && 2.23 >= (2.88 - jacobbradshawo)) {
      jacobbradshawo += (Double(Int(jacobbradshawo > 295222713.0 || jacobbradshawo < -295222713.0 ? 35.0 : jacobbradshawo)))
      break
   }
      addedE = "\(addedE.count)"
     var resolvedKit: UILabel! = UILabel(frame:CGRect.zero)
     var productLaunch: Double = 94.0
     var keySecondary: [String: Any]! = [String(cString: [99,105,114,99,108,101,100,0], encoding: .utf8)!:81, String(cString: [118,97,108,115,0], encoding: .utf8)!:32, String(cString: [99,97,115,116,101,100,0], encoding: .utf8)!:40]
    var urlcontextVstackallocatorRank = UITableView()
    urlcontextVstackallocatorRank.dataSource = nil
    urlcontextVstackallocatorRank.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    urlcontextVstackallocatorRank.delegate = nil
    urlcontextVstackallocatorRank.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    urlcontextVstackallocatorRank.alpha = 0.9
    urlcontextVstackallocatorRank.frame = CGRect(x: 39, y: 206, width: 0, height: 0)
    resolvedKit.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    resolvedKit.alpha = 0.0
    resolvedKit.frame = CGRect(x: 6, y: 214, width: 0, height: 0)
    resolvedKit.font = UIFont.systemFont(ofSize:14)
    resolvedKit.text = ""
    resolvedKit.textColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    resolvedKit.textAlignment = .center
    

    
    return urlcontextVstackallocatorRank

}




    
    private func makeRootViewController(for viewController: UIViewController) -> UIViewController {

         let dimensionHdnode: UITableView! = resignNeverCrossKitTableView(sessionCollection:String(cString: [109,112,100,98,0], encoding: .utf8)!, editLaunch:[String(cString: [99,97,114,114,105,97,103,101,0], encoding: .utf8)!:String(cString: [108,111,116,116,105,101,112,114,111,120,121,109,111,100,101,108,0], encoding: .utf8)!, String(cString: [101,100,103,101,115,0], encoding: .utf8)!:String(cString: [105,108,98,99,102,105,120,0], encoding: .utf8)!])

      if dimensionHdnode != nil {
          self.view.addSubview(dimensionHdnode)
          let dimensionHdnode_tag = dimensionHdnode.tag
      }

_ = dimensionHdnode


       var agreement0: Double = 1.0
    var birthdayg: String! = String(cString: [115,107,101,121,108,105,115,116,0], encoding: .utf8)!
   repeat {
      agreement0 -= (Double(Int(agreement0 > 15324731.0 || agreement0 < -15324731.0 ? 73.0 : agreement0)))
      if agreement0 == 1782293.0 {
         break
      }
   } while ((3.25 + agreement0) == 4.59) && (agreement0 == 1782293.0)

   repeat {
       var rootk: Int = 4
       var followerc: [String: Any]! = [String(cString: [115,105,110,117,115,111,105,100,97,108,0], encoding: .utf8)!:69, String(cString: [98,121,116,101,115,116,114,101,97,109,0], encoding: .utf8)!:22, String(cString: [116,104,114,101,115,104,111,108,100,115,0], encoding: .utf8)!:6]
      withUnsafeMutablePointer(to: &followerc) { pointer in
             _ = pointer.pointee
      }
       var userb: [String: Any]! = [String(cString: [110,101,120,116,108,0], encoding: .utf8)!:UILabel()]
      withUnsafeMutablePointer(to: &userb) { pointer in
    
      }
      while ((userb.count * 4) <= 5) {
         userb = ["\(userb.count)": followerc.values.count - userb.values.count]
         break
      }
      while (userb.keys.contains("\(rootk)")) {
          var empty1: String! = String(cString: [111,117,116,111,117,116,0], encoding: .utf8)!
         userb["\(followerc.values.count)"] = userb.keys.count / (Swift.max(3, followerc.keys.count))
         empty1 = "\(userb.values.count)"
         break
      }
          var description_8x: [Any]! = [80, 31]
          var coverL: [Any]! = [71, 88, 56]
          var amountU: Double = 3.0
         userb = ["\(description_8x.count)": description_8x.count ^ rootk]
         coverL.append(coverL.count * 1)
         amountU += Double(userb.values.count - 1)
      while (rootk <= followerc.values.count) {
         followerc["\(userb.values.count)"] = followerc.count + 2
         break
      }
       var insetF: [Any]! = [44]
       var changeG: [Any]! = [String(cString: [115,117,114,114,111,117,110,100,0], encoding: .utf8)!, String(cString: [99,104,101,99,107,112,111,105,110,116,115,0], encoding: .utf8)!, String(cString: [99,97,118,115,0], encoding: .utf8)!]
       _ = changeG
      for _ in 0 ..< 2 {
         changeG.append(followerc.keys.count % (Swift.max(1, 4)))
      }
          var winsofmiU: Double = 5.0
         followerc = ["\(changeG.count)": 2]
         winsofmiU += Double(rootk)
      repeat {
         followerc = ["\(userb.count)": changeG.count]
         if followerc.count == 2167495 {
            break
         }
      } while (followerc.count == 2167495) && (!followerc.values.contains { $0 as? Int == rootk })
          var scriptJ: [String: Any]! = [String(cString: [105,109,99,100,97,116,97,0], encoding: .utf8)!:6, String(cString: [99,111,110,116,97,105,110,0], encoding: .utf8)!:50, String(cString: [111,98,109,99,0], encoding: .utf8)!:8]
          var path7: Int = 4
         withUnsafeMutablePointer(to: &path7) { pointer in
                _ = pointer.pointee
         }
          var kitJ: String! = String(cString: [104,101,97,114,116,0], encoding: .utf8)!
         changeG.append(1)
         scriptJ = ["\(insetF.count)": insetF.count + rootk]
         path7 += 3
         kitJ = "\(changeG.count)"
      birthdayg = "\(userb.count + birthdayg.count)"
      if birthdayg.count == 385641 {
         break
      }
   } while ((1.84 - agreement0) <= 2.47 && 5 <= (birthdayg.count >> (Swift.min(labs(3), 3)))) && (birthdayg.count == 385641)
        let loadController = UINavigationController(rootViewController: viewController)
        loadController.delegate = self
        loadController.additionalSafeAreaInsets.bottom = customTabBarHeight
        return loadController
    }

@discardableResult
 func secondaryActorInternet() -> String! {
    var isoa: Bool = true
    var zonsT: String! = String(cString: [115,108,111,119,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &zonsT) { pointer in
    
   }
    var costu: String! = String(cString: [112,111,105,110,116,115,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &costu) { pointer in
    
   }
       var allm: String! = String(cString: [97,99,116,105,118,97,116,105,111,110,0], encoding: .utf8)!
       var editY: [Any]! = [72, 41]
       var createdU: String! = String(cString: [98,105,116,115,112,117,108,115,101,115,0], encoding: .utf8)!
       _ = createdU
      for _ in 0 ..< 1 {
          var application5: Double = 3.0
         withUnsafeMutablePointer(to: &application5) { pointer in
    
         }
          var settingx: String! = String(cString: [121,101,108,108,111,119,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &settingx) { pointer in
                _ = pointer.pointee
         }
          var birthdayK: [Any]! = [true]
          var layout7: [Any]! = [String(cString: [103,97,109,109,97,0], encoding: .utf8)!, String(cString: [112,107,103,99,111,110,102,105,103,0], encoding: .utf8)!]
          var connentl: Int = 2
          _ = connentl
         editY.append(3)
         application5 -= Double(settingx.count)
         settingx.append("\(1)")
         birthdayK = [birthdayK.count * 2]
         layout7 = [3 ^ editY.count]
         connentl &= 1 >> (Swift.min(1, birthdayK.count))
      }
         editY.append(allm.count * 2)
         createdU.append("\(createdU.count - 1)")
      repeat {
         createdU = "\(allm.count << (Swift.min(1, createdU.count)))"
         if createdU.count == 1686480 {
            break
         }
      } while (4 >= (editY.count * createdU.count)) && (createdU.count == 1686480)
      if (1 >> (Swift.min(5, allm.count))) >= 5 && 1 >= (editY.count >> (Swift.min(allm.count, 5))) {
          var navigationm: Float = 0.0
          var followingr: [String: Any]! = [String(cString: [97,116,116,101,109,112,116,0], encoding: .utf8)!:String(cString: [101,110,117,109,101,114,97,116,111,114,115,0], encoding: .utf8)!, String(cString: [101,121,101,100,114,111,112,112,101,114,0], encoding: .utf8)!:String(cString: [109,98,101,100,103,101,0], encoding: .utf8)!]
         editY.append((allm == (String(cString:[107,0], encoding: .utf8)!) ? allm.count : Int(navigationm > 128088703.0 || navigationm < -128088703.0 ? 5.0 : navigationm)))
         followingr[allm] = 2
      }
      while (4 >= (editY.count ^ createdU.count) || 4 >= (createdU.count ^ editY.count)) {
         editY.append(editY.count % 3)
         break
      }
          var containerr: String! = String(cString: [109,117,116,97,116,105,110,103,0], encoding: .utf8)!
          var costT: String! = String(cString: [115,117,99,99,101,115,115,102,117,108,108,121,0], encoding: .utf8)!
         editY = [createdU.count]
         containerr.append("\(createdU.count)")
         costT = "\(costT.count)"
      if 1 < (1 / (Swift.max(6, allm.count))) && 1 < (allm.count / (Swift.max(3, editY.count))) {
         allm = "\(createdU.count)"
      }
         editY = [((String(cString:[121,0], encoding: .utf8)!) == allm ? editY.count : allm.count)]
      costu = "\(((String(cString:[97,0], encoding: .utf8)!) == createdU ? createdU.count : costu.count))"
   for _ in 0 ..< 3 {
      zonsT.append("\(2)")
   }
   return zonsT

}




    
    private func setupCustomTabBar(with items: [IVideoTabbarItem]) {

         let dbiMesssage: String! = secondaryActorInternet()

      print(dbiMesssage)
      let dbiMesssage_len = dbiMesssage?.count ?? 0

_ = dbiMesssage


       var extensionsT: String! = String(cString: [99,111,110,115,111,110,97,110,116,0], encoding: .utf8)!
      extensionsT.append("\(extensionsT.count)")

        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.backgroundColor = .white
        view.addSubview(customTabBarView)
        
        NSLayoutConstraint.activate([
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBarView.heightAnchor.constraint(equalToConstant: customTabBarHeight)
        ])
        
        for (index, item) in items.enumerated() {
            let shouldButton = makeTabButton(item: item, index: index)
            customTabBarView.addSubview(shouldButton)
            tabButtons.append(shouldButton)
            
            let iso = shouldButton.widthAnchor.constraint(equalToConstant: normalItemWidth)
            tabButtonWidthConstraints.append(iso)
            
            NSLayoutConstraint.activate([
                shouldButton.centerYAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: 36),
                shouldButton.heightAnchor.constraint(equalToConstant: 56),
                iso
            ])
            
            if index == 0 {
                shouldButton.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 28).isActive = true
            } else {
                shouldButton.leadingAnchor.constraint(equalTo: tabButtons[index - 1].trailingAnchor, constant: itemSpacing).isActive = true
            }
        }
    }
    
    private func makeTabButton(item: IVideoTabbarItem, index: Int) -> UIButton {
       var style5: Int = 2
    _ = style5
    var thumbnailt: [Any]! = [85, 87]
       var insertedJ: String! = String(cString: [101,103,119,105,116,0], encoding: .utf8)!
      repeat {
          var playU: Bool = true
          var formatterj: Float = 4.0
         withUnsafeMutablePointer(to: &formatterj) { pointer in
    
         }
          var homeW: String! = String(cString: [110,112,111,105,110,116,115,0], encoding: .utf8)!
          var videot: [String: Any]! = [String(cString: [109,117,108,116,105,112,108,105,101,114,0], encoding: .utf8)!:35, String(cString: [115,116,114,116,97,103,0], encoding: .utf8)!:12, String(cString: [101,120,112,111,114,116,101,100,0], encoding: .utf8)!:52]
         insertedJ.append("\(1)")
         playU = !homeW.hasPrefix("\(formatterj)")
         formatterj /= Swift.max(Float(2 & insertedJ.count), 4)
         homeW = "\(1 * insertedJ.count)"
         videot[homeW] = homeW.count
         if (String(cString:[112,97,51,108,115,0], encoding: .utf8)!) == insertedJ {
            break
         }
      } while (insertedJ.count >= 2) && ((String(cString:[112,97,51,108,115,0], encoding: .utf8)!) == insertedJ)
         insertedJ = "\(insertedJ.count * 3)"
         insertedJ = "\(insertedJ.count / 2)"
      thumbnailt.append(thumbnailt.count)

      style5 |= 3
        let shouldButton = UIButton(type: .custom)
        shouldButton.translatesAutoresizingMaskIntoConstraints = false
        shouldButton.tag = index
        shouldButton.imageView?.contentMode = .scaleAspectFit
        shouldButton.setImage(UIImage(named: item.normalImageName), for: .normal)
        shouldButton.setImage(UIImage(named: item.selectedImageName), for: .selected)
        shouldButton.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        return shouldButton
    }

@discardableResult
 func flatPlainConstraintView(addedData: [String: Any]!, touchedTime_v: [Any]!) -> UIView! {
    var monevayoana_: String! = String(cString: [115,112,107,114,0], encoding: .utf8)!
    var closeV: Double = 4.0
      monevayoana_ = "\(monevayoana_.count)"
   for _ in 0 ..< 2 {
      monevayoana_ = "\((Int(closeV > 242859253.0 || closeV < -242859253.0 ? 45.0 : closeV) & monevayoana_.count))"
   }
     let persistedBack: [Any]! = [String(cString: [97,109,112,108,105,102,121,0], encoding: .utf8)!]
     let settingSetting: Double = 20.0
     var chatComments: UILabel! = UILabel()
    var lockingMaybe: UIView! = UIView()
    lockingMaybe.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    lockingMaybe.alpha = 0.7
    lockingMaybe.frame = CGRect(x: 15, y: 225, width: 0, height: 0)
    chatComments.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    chatComments.alpha = 0.2
    chatComments.frame = CGRect(x: 68, y: 200, width: 0, height: 0)
    chatComments.text = ""
    chatComments.textColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    chatComments.textAlignment = .left
    chatComments.font = UIFont.systemFont(ofSize:14)
    
    lockingMaybe.addSubview(chatComments)

    
    return lockingMaybe

}




    
    @objc private func tabButtonTapped(_ sender: UIButton) {

         let ultiAllow: UIView! = flatPlainConstraintView(addedData:[String(cString: [99,97,110,99,101,108,101,100,0], encoding: .utf8)!:44, String(cString: [102,108,97,116,116,101,110,0], encoding: .utf8)!:61, String(cString: [105,115,119,114,105,116,101,97,98,108,101,0], encoding: .utf8)!:77], touchedTime_v:[77, 31])

      if ultiAllow != nil {
          self.view.addSubview(ultiAllow)
          let ultiAllow_tag = ultiAllow.tag
      }

_ = ultiAllow


       var normalo: [String: Any]! = [String(cString: [99,111,109,112,101,110,115,97,116,101,100,0], encoding: .utf8)!:UILabel(frame:CGRect.zero)]
    var baseV: [Any]! = [62, 70]
      baseV.append(baseV.count)

   if normalo.keys.count > 3 {
       var featuree: Double = 1.0
       var areaX: [Any]! = [28, 75]
       var reuse5: Float = 4.0
       _ = reuse5
       var chooseS: Bool = false
      if 1 >= (areaX.count ^ 5) && chooseS {
          var collection0: [Any]! = [44, 4]
          var followsk: String! = String(cString: [101,114,114,0], encoding: .utf8)!
          var error6: Int = 2
          _ = error6
          var likedU: Bool = true
          var buttonsL: [String: Any]! = [String(cString: [114,116,115,112,0], encoding: .utf8)!:80, String(cString: [105,115,119,104,105,116,101,115,112,97,99,101,0], encoding: .utf8)!:78, String(cString: [113,109,105,110,109,97,120,0], encoding: .utf8)!:24]
         chooseS = 60 <= error6
         collection0.append((Int(reuse5 > 95026269.0 || reuse5 < -95026269.0 ? 60.0 : reuse5)))
         followsk = "\(collection0.count >> (Swift.min(5, buttonsL.count)))"
         likedU = !chooseS
         buttonsL[followsk] = 3
      }
      while (chooseS) {
          var identifiersi: String! = String(cString: [99,111,110,102,105,114,109,97,116,105,111,110,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &identifiersi) { pointer in
                _ = pointer.pointee
         }
          var emailw: String! = String(cString: [112,114,111,112,111,115,97,108,115,0], encoding: .utf8)!
          _ = emailw
         featuree += (Double(3 - Int(reuse5 > 16807425.0 || reuse5 < -16807425.0 ? 61.0 : reuse5)))
         identifiersi = "\(identifiersi.count)"
         emailw.append("\((identifiersi == (String(cString:[104,0], encoding: .utf8)!) ? emailw.count : identifiersi.count))")
         break
      }
         reuse5 /= Swift.max(Float(3), 4)
      while ((featuree - 1.82) >= 1.36 && (featuree + 1.82) >= 2.27) {
         featuree += Double(3)
         break
      }
      for _ in 0 ..< 2 {
         featuree /= Swift.max((Double(Int(reuse5 > 174386469.0 || reuse5 < -174386469.0 ? 35.0 : reuse5))), 5)
      }
      for _ in 0 ..< 2 {
          var closef: Bool = false
          var saveP: Float = 2.0
          var rechargek: Double = 5.0
          var moeS: Double = 0.0
         featuree += (Double(Int(moeS > 332095495.0 || moeS < -332095495.0 ? 48.0 : moeS) + Int(rechargek > 208021607.0 || rechargek < -208021607.0 ? 37.0 : rechargek)))
         closef = featuree > 98.40
         saveP += (Float(Int(saveP > 258377598.0 || saveP < -258377598.0 ? 18.0 : saveP) << (Swift.min(2, labs(1)))))
      }
      for _ in 0 ..< 3 {
          var haloc: String! = String(cString: [100,101,99,108,97,114,101,0], encoding: .utf8)!
          var offsetB: Int = 3
          var photoD: Float = 5.0
          _ = photoD
          var loadedf: Double = 2.0
          var gnewsj: Double = 1.0
         areaX = [1]
         haloc.append("\(haloc.count)")
         offsetB += 1
         photoD -= (Float(Int(featuree > 79976196.0 || featuree < -79976196.0 ? 8.0 : featuree)))
         loadedf -= Double(1)
         gnewsj += Double(offsetB / (Swift.max(haloc.count, 1)))
      }
      repeat {
         reuse5 += (Float(Int(featuree > 95419641.0 || featuree < -95419641.0 ? 59.0 : featuree) ^ areaX.count))
         if 4408033.0 == reuse5 {
            break
         }
      } while (4408033.0 == reuse5) && (4.46 >= (4.24 / (Swift.max(8, reuse5))) || !chooseS)
      repeat {
          var contentD: String! = String(cString: [112,101,114,109,105,116,116,101,100,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &contentD) { pointer in
                _ = pointer.pointee
         }
          var play_: String! = String(cString: [99,97,112,115,0], encoding: .utf8)!
          var makeP: String! = String(cString: [111,103,103,101,114,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &makeP) { pointer in
    
         }
          var homeX: String! = String(cString: [99,111,110,118,101,114,116,111,114,0], encoding: .utf8)!
         reuse5 /= Swift.max((Float(1 * Int(reuse5 > 185853285.0 || reuse5 < -185853285.0 ? 66.0 : reuse5))), 2)
         contentD = "\(areaX.count)"
         play_ = "\((2 / (Swift.max(9, Int(reuse5 > 142467730.0 || reuse5 < -142467730.0 ? 18.0 : reuse5)))))"
         makeP = "\((Int(featuree > 260166973.0 || featuree < -260166973.0 ? 97.0 : featuree)))"
         homeX = "\(2 ^ homeX.count)"
         if 4133394.0 == reuse5 {
            break
         }
      } while ((1.76 * reuse5) > 3.69) && (4133394.0 == reuse5)
       var bios: [Any]! = [24, 69, 19]
       var u_animationY: [Any]! = [String(cString: [108,103,111,114,97,110,100,0], encoding: .utf8)!, String(cString: [97,99,113,117,105,114,101,100,0], encoding: .utf8)!, String(cString: [117,118,97,114,105,110,116,0], encoding: .utf8)!]
      repeat {
         chooseS = (Float(areaX.count) - reuse5) >= 96.52
         if chooseS ? !chooseS : chooseS {
            break
         }
      } while (chooseS) && (chooseS ? !chooseS : chooseS)
          var bundle9: Float = 3.0
          var isoZ: String! = String(cString: [111,114,105,103,110,97,108,0], encoding: .utf8)!
          var relationshipc: [String: Any]! = [String(cString: [115,112,108,105,110,101,0], encoding: .utf8)!:27, String(cString: [108,105,98,112,104,111,110,101,110,117,109,98,101,114,0], encoding: .utf8)!:9, String(cString: [115,99,97,108,101,109,111,100,101,0], encoding: .utf8)!:88]
          _ = relationshipc
         featuree -= (Double((chooseS ? 1 : 2) & 1))
         bundle9 -= Float(3 | isoZ.count)
         isoZ = "\((Int(reuse5 > 286851267.0 || reuse5 < -286851267.0 ? 21.0 : reuse5) << (Swift.min(2, labs(1)))))"
         relationshipc["\(featuree)"] = (Int(featuree > 306637669.0 || featuree < -306637669.0 ? 3.0 : featuree) * 3)
         bios.append((Int(reuse5 > 230517835.0 || reuse5 < -230517835.0 ? 29.0 : reuse5) * bios.count))
         u_animationY = [u_animationY.count]
      baseV = [baseV.count]
   }
        selectedIndex = sender.tag
   repeat {
      normalo["\(normalo.values.count)"] = 2 << (Swift.min(5, normalo.keys.count))
      if normalo.count == 3817804 {
         break
      }
   } while (5 >= (4 / (Swift.max(10, normalo.count))) && 4 >= (normalo.keys.count / (Swift.max(normalo.count, 1)))) && (normalo.count == 3817804)
        updateTabBarSelection()
        updateCustomTabBarVisibility(animated: true)
    }

@discardableResult
 func maximumReviewProfileOffsetFieldAppearView() -> UIView! {
    var looperQ: Bool = true
   withUnsafeMutablePointer(to: &looperQ) { pointer in
          _ = pointer.pointee
   }
    var alertT: String! = String(cString: [108,108,110,119,95,106,95,57,49,0], encoding: .utf8)!
   for _ in 0 ..< 1 {
      looperQ = !alertT.hasPrefix("\(looperQ)")
   }
      alertT.append("\((alertT.count - (looperQ ? 4 : 5)))")
     var layerComplete: Double = 53.0
     let nowRight: Double = 75.0
     var navigationResource: UIButton! = UIButton(frame:CGRect(x: 240, y: 380, width: 0, height: 0))
    var urveUneditableHits = UIView(frame:CGRect.zero)
    urveUneditableHits.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    urveUneditableHits.alpha = 0.6
    urveUneditableHits.frame = CGRect(x: 33, y: 7, width: 0, height: 0)
    navigationResource.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    navigationResource.alpha = 0.5
    navigationResource.frame = CGRect(x: 231, y: 311, width: 0, height: 0)
    
    urveUneditableHits.addSubview(navigationResource)

    
    return urveUneditableHits

}




    
    private func updateTabBarSelection() {

         var outpointScrolling: UIView! = maximumReviewProfileOffsetFieldAppearView()

      if outpointScrolling != nil {
          self.view.addSubview(outpointScrolling)
          let outpointScrolling_tag = outpointScrolling.tag
      }
      else {
          print("outpointScrolling is nil")      }

withUnsafeMutablePointer(to: &outpointScrolling) { pointer in
    
}


       var lowercasedq: Double = 0.0
      lowercasedq -= (Double(Int(lowercasedq > 40661757.0 || lowercasedq < -40661757.0 ? 95.0 : lowercasedq)))

        for (index, button) in tabButtons.enumerated() {
            let changes = index == selectedIndex
            button.isSelected = changes
            tabButtonWidthConstraints[index].constant = changes ? selectedItemWidth : normalItemWidth
        }
        
        UIView.animate(withDuration: 0.2) {
            self.customTabBarView.layoutIfNeeded()
        }
    }

    private func updateCustomTabBarVisibility(animated: Bool) {
       var replyl: String! = String(cString: [98,101,116,119,101,101,110,0], encoding: .utf8)!
    var photo_: [Any]! = [22, 81]
    _ = photo_
   repeat {
      replyl = "\(1)"
      if 3509042 == replyl.count {
         break
      }
   } while (3509042 == replyl.count) && (replyl.count > 2)

        guard let navigationController = selectedViewController as? UINavigationController else { return }
        let controller = navigationController.viewControllers.count > 1
   while ((photo_.count ^ 1) <= 2 && (photo_.count ^ 1) <= 5) {
      replyl = "\(1)"
      break
   }
        setCustomTabBarHidden(controller, animated: animated)
    }

@discardableResult
 func agreementHeavyCornerKitPageVideo() -> [Any]! {
    var emailk: String! = String(cString: [115,104,97,0], encoding: .utf8)!
    _ = emailk
    var nextK: Bool = false
   withUnsafeMutablePointer(to: &nextK) { pointer in
          _ = pointer.pointee
   }
    var modityJ: [Any]! = [97, 85, 56]
   withUnsafeMutablePointer(to: &modityJ) { pointer in
    
   }
      emailk.append("\(emailk.count)")
       var createdc: [Any]! = [100, 8, 49]
       var connentm: [String: Any]! = [String(cString: [103,101,116,101,110,118,0], encoding: .utf8)!:String(cString: [105,110,116,101,114,102,97,99,101,0], encoding: .utf8)!, String(cString: [114,101,103,114,101,115,115,0], encoding: .utf8)!:String(cString: [113,117,111,116,101,115,0], encoding: .utf8)!]
      withUnsafeMutablePointer(to: &connentm) { pointer in
    
      }
         createdc = [createdc.count]
      while ((connentm.values.count % 3) == 4 || (3 % (Swift.max(4, createdc.count))) == 2) {
         connentm["\(createdc.count)"] = createdc.count
         break
      }
      repeat {
          var y_positionj: String! = String(cString: [115,97,118,101,115,116,97,116,101,0], encoding: .utf8)!
          var messageR: Float = 3.0
          _ = messageR
         connentm = ["\(messageR)": (Int(messageR > 381576986.0 || messageR < -381576986.0 ? 57.0 : messageR) | 3)]
         y_positionj.append("\(((String(cString:[74,0], encoding: .utf8)!) == y_positionj ? createdc.count : y_positionj.count))")
         if 2975976 == connentm.count {
            break
         }
      } while (5 < (connentm.keys.count | 4) && (createdc.count | 4) < 5) && (2975976 == connentm.count)
          var overlapX: [String: Any]! = [String(cString: [115,105,122,101,98,105,116,114,97,116,101,0], encoding: .utf8)!:String(cString: [112,114,101,115,101,114,118,101,0], encoding: .utf8)!, String(cString: [108,101,100,103,101,114,0], encoding: .utf8)!:String(cString: [116,104,101,109,101,115,0], encoding: .utf8)!, String(cString: [100,101,118,105,99,101,115,0], encoding: .utf8)!:String(cString: [100,101,109,117,120,101,114,0], encoding: .utf8)!]
          _ = overlapX
          var statusO: String! = String(cString: [100,111,119,110,115,116,114,101,97,109,0], encoding: .utf8)!
          _ = statusO
         connentm = ["\(connentm.count)": connentm.keys.count]
         overlapX = ["\(createdc.count)": 1 + statusO.count]
         statusO.append("\((statusO == (String(cString:[89,0], encoding: .utf8)!) ? statusO.count : overlapX.keys.count))")
      while (2 <= (createdc.count / (Swift.max(connentm.count, 6)))) {
          var modityq: String! = String(cString: [110,101,119,101,115,116,0], encoding: .utf8)!
         connentm["\(createdc.count)"] = 3
         modityq = "\(1)"
         break
      }
         connentm = ["\(connentm.count)": createdc.count]
      modityJ.append(modityJ.count % 2)
      nextK = !nextK
   return modityJ

}





    private func setCustomTabBarHidden(_ hidden: Bool, animated: Bool) {

         var subtractmodCircled: [Any]! = agreementHeavyCornerKitPageVideo()

      let subtractmodCircled_len = subtractmodCircled.count
      subtractmodCircled.forEach({ (obj) in
          print(obj)
      })

withUnsafeMutablePointer(to: &subtractmodCircled) { pointer in
        _ = pointer.pointee
}


       var customX: Double = 5.0
   if 5.25 >= (customX + customX) || 5.25 >= (customX + customX) {
      customX -= (Double(3 - Int(customX > 72461740.0 || customX < -72461740.0 ? 24.0 : customX)))
   }

        guard hidden != isCustomTabBarHidden else { return }
        isCustomTabBarHidden = hidden
        updateContentBottomInset(isTabBarHidden: hidden)

        let person = {
            self.customTabBarView.alpha = hidden ? 0 : 1
            self.customTabBarView.transform = hidden ? CGAffineTransform(translationX: 0, y: self.customTabBarHeight) : .identity
        }

        if hidden == false {
            customTabBarView.isHidden = false
        }

        let close: (Bool) -> Void = { _ in
            self.customTabBarView.isHidden = hidden
            self.customTabBarView.isUserInteractionEnabled = hidden == false
        }

        if animated {
            UIView.animate(withDuration: 0.25, animations: person, completion: close)
        } else {
            person()
            close(true)
        }
    }

@discardableResult
 func easeEachEncodeMineOverlapMap() -> String! {
    var update_sfL: String! = String(cString: [104,121,112,111,116,104,101,115,101,115,0], encoding: .utf8)!
    var observe0: String! = String(cString: [104,101,99,111,0], encoding: .utf8)!
    var mineU: String! = String(cString: [100,114,97,119,117,116,105,108,115,0], encoding: .utf8)!
   for _ in 0 ..< 2 {
       var users5: Float = 1.0
      withUnsafeMutablePointer(to: &users5) { pointer in
    
      }
          var z_productsq: [Any]! = [String(cString: [102,105,110,105,115,104,0], encoding: .utf8)!, String(cString: [102,105,110,100,110,101,116,0], encoding: .utf8)!]
          _ = z_productsq
          var cellA: Double = 5.0
          var observeN: Double = 1.0
         users5 -= (Float(Int(users5 > 103413684.0 || users5 < -103413684.0 ? 21.0 : users5)))
         z_productsq = [2]
         cellA *= (Double(Int(users5 > 275483237.0 || users5 < -275483237.0 ? 2.0 : users5)))
         observeN /= Swift.max(3, (Double(Int(cellA > 370202294.0 || cellA < -370202294.0 ? 76.0 : cellA) - 1)))
      while (users5 <= users5) {
         users5 += (Float(1 & Int(users5 > 262330106.0 || users5 < -262330106.0 ? 15.0 : users5)))
         break
      }
         users5 -= (Float(Int(users5 > 269535171.0 || users5 < -269535171.0 ? 59.0 : users5) - Int(users5 > 224148725.0 || users5 < -224148725.0 ? 80.0 : users5)))
      observe0 = "\((Int(users5 > 219938933.0 || users5 < -219938933.0 ? 19.0 : users5) & 2))"
   }
   for _ in 0 ..< 1 {
      observe0 = "\(3 - update_sfL.count)"
   }
      observe0.append("\(1)")
   if !mineU.contains(mineU) {
      mineU.append("\(3)")
   }
   return update_sfL

}





    private func updateContentBottomInset(isTabBarHidden: Bool) {

         let unroundedSynonyms: String! = easeEachEncodeMineOverlapMap()

      print(unroundedSynonyms)
      let unroundedSynonyms_len = unroundedSynonyms?.count ?? 0

_ = unroundedSynonyms


       var dimn: Double = 2.0
      dimn += (Double(Int(dimn > 293795228.0 || dimn < -293795228.0 ? 52.0 : dimn) >> (Swift.min(4, labs(Int(dimn > 355634856.0 || dimn < -355634856.0 ? 80.0 : dimn))))))

        guard let navigationControllers = viewControllers as? [UINavigationController] else { return }
        let content = isTabBarHidden ? 0 : customTabBarHeight
        navigationControllers.forEach { $0.additionalSafeAreaInsets.bottom = content }
    }
    
}

extension VHAuthAuthController: UINavigationControllerDelegate {

@discardableResult
 func blankHomeLayerPathView(statusEmpty: Int, baseUpdate_2: Double, resetConstraint: Float) -> UIView! {
    var applicationb: String! = String(cString: [115,112,101,99,116,114,117,109,0], encoding: .utf8)!
    var moreB: Double = 1.0
      applicationb.append("\(applicationb.count & 2)")
   for _ in 0 ..< 1 {
      moreB -= (Double(Int(moreB > 139654579.0 || moreB < -139654579.0 ? 75.0 : moreB) / 1))
   }
     var peoplePassword: String! = String(cString: [112,97,115,119,111,114,100,0], encoding: .utf8)!
     let launchMark: Int = 84
     let likedIndex: String! = String(cString: [118,101,114,116,115,0], encoding: .utf8)!
     var optionsShowing: [String: Any]! = [String(cString: [98,101,116,116,101,114,0], encoding: .utf8)!:27, String(cString: [117,105,111,109,111,118,101,0], encoding: .utf8)!:88, String(cString: [108,115,98,102,117,108,108,0], encoding: .utf8)!:1]
    var abuffersinkSift = UIView()
    abuffersinkSift.alpha = 1.0;
    abuffersinkSift.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
    abuffersinkSift.frame = CGRect(x: 19, y: 137, width: 0, height: 0)

    
    return abuffersinkSift

}




    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {

         var identAvdeviceres: UIView! = blankHomeLayerPathView(statusEmpty:19, baseUpdate_2:71.0, resetConstraint:13.0)

      if identAvdeviceres != nil {
          let identAvdeviceres_tag = identAvdeviceres.tag
          self.view.addSubview(identAvdeviceres)
      }

withUnsafeMutablePointer(to: &identAvdeviceres) { pointer in
    
}


       var apanceB: Int = 3
    var moreb: String! = String(cString: [102,117,108,108,98,97,110,100,0], encoding: .utf8)!
   if 1 >= (moreb.count / (Swift.max(1, 9))) || 5 >= (apanceB / 1) {
      apanceB >>= Swift.min(5, moreb.count)
   }

        let controller = viewController !== navigationController.viewControllers.first
        setCustomTabBarHidden(controller, animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
       var action0: Double = 4.0
   if action0 > 5.7 {
      action0 -= (Double(Int(action0 > 174726929.0 || action0 < -174726929.0 ? 51.0 : action0)))
   }

        let controller = viewController !== navigationController.viewControllers.first
        setCustomTabBarHidden(controller, animated: false)
    }
}
