//
//  CandPUITests.swift
//  CandPUITests
//
//  Created by 合田佑司 on 2017/02/19.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import XCTest

class CandPUITests: XCTestCase {
    
    let board = UIPasteboard.general
    var clipBoard : Array<String> = []
    var fixaClipBoard : Array<String> = []
    var setData : Dictionary<String, Any?> = [:]
    let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test3SelectCell() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["test29"].tap()
        tablesQuery.staticTexts["test28"].tap()
        tablesQuery.staticTexts["test27"].tap()
        
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
