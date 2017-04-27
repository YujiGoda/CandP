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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
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
    }
    
    func test2SetClipBoard() {
        let viewController = ViewController()
        for i in 1...30 {
            board.string  = "test" + "\(i)"
            viewController.saveClipBoard()
        }
        getUserDefaultData()
        XCTAssertEqual(clipBoard.count, 30)
    }
    
    func test3NumberOfClipBoard() {
        class saveNumberViewController : SaveNnumberSetViewController {
            override func viewDidLoad() {
                //useDefaultに保存されているクリップボード一覧を取得
                if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
                    clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
                }
            }
        }
        let saveNumberView = saveNumberViewController()
        saveNumberView.viewDidLoad()
        saveNumberView.setSaveNumberFortest(selectNumber: 25)
        getUserDefaultData()
        XCTAssertEqual(clipBoard.count, 25)
    }
    
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
    }
    
}
