//
//  CandPTests.swift
//  CandPTests
//
//  Created by 合田佑司 on 2017/02/19.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import XCTest
@testable import CandP

class CandPTests: XCTestCase {
    
    let board = UIPasteboard.general
    var clipBoard : Array<String> = []
    var fixaClipBoard : Array<String> = []
    var setData : Dictionary<String, Any?> = [:]
    
    override func setUp() {
        super.setUp()
        
        //設定情報の初期化
        let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
        useDefaults.set(setData, forKey: dataPass.useDafaultKeyForSetData.rawValue)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //クリップボード一覧と保護一覧の初期化テスト
    func test1AllDelte() {
        class settingView : SettingViewController {
            override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
                print("show OK")
                return
            }
        }
        let set = settingView()
        set.deleteClip(action: UIAlertAction())
        getUserDefaultData()
        XCTAssertEqual(clipBoard, [])
        XCTAssertEqual(fixaClipBoard, [])
    }
    
    //テキスト"test1"〜"test30"をクリップボードの順番に格納
    func test2SetClipBoard() {
        let viewController = ViewController()
        for i in 1...30 {
            board.string  = "test" + "\(i)"
            viewController.saveClipBoard()
        }
        getUserDefaultData()
        XCTAssertEqual(clipBoard.count, 30)
    }
    
//    //保存件数設定のテスト
//    func test3NumberOfClipBoard() {
//        class saveNumberViewController : SaveNnumberSetViewController {
//            override func viewDidLoad() {
//                //useDefaultに保存されているクリップボード一覧を取得
//                if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
//                    clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
//                }
//            }
//        }
//        let saveNumberView = saveNumberViewController()
//        saveNumberView.viewDidLoad()
//        saveNumberView.setSaveNumberFortest(selectNumber: 25)
//        getUserDefaultData()
//        XCTAssertEqual(clipBoard.count, 25)
//    }
//    
//    func test4SelectTableCell() {
//        class viewController : ViewController {
//            override func viewDidLoad() {
//                //useDefaultに保存されているクリップボード一覧を取得
//                if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
//                    clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
//                }
//                //保護されているクリップボード一覧を取得
//                if useDefaults.object(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) != nil {
//                    fixaClipBoard = useDefaults.array(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) as! Array<String>
//                }
//                //useDefaultに保存されている設定情報を取得
//                if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
//                    setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
//                }
//                
//                NotificationCenter.default.addObserver(self, selector: #selector(self.saveClipBoard), name: NSNotification.Name.UIPasteboardChanged, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(self.returnFormBackbround), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//            }
//            override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                board.setValue(clipBoard[indexPath.row], forPasteboardType: "public.text")
//            }
//        }
//        let view = viewController()
//        let index = IndexPath.init(row: 1, section: 0)
//        view.viewDidLoad()
//        view.tableView(UITableView(), didSelectRowAt: index)
//        
//        getUserDefaultData()
//        XCTAssertEqual(clipBoard[0], "test29")
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getUserDefaultData() {
        //useDefaultに保存されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        //保護されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) != nil {
            fixaClipBoard = useDefaults.array(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) as! Array<String>
        }
    }
    
}
