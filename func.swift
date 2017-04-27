//
//  func.swift
//  CandP
//
//  Created by 合田佑司 on 2017/04/22.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import Foundation

let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
var setData : Dictionary<String, Any?> = [:]

func checkFixaTextDelete(_ deleteText : String) {
    //useDefaultに保存されている設定情報を取得
    if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
        setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
    }
    
    if let fixaText = setData[setDataDictionary.fixaText.rawValue] as? String {
        if fixaText == deleteText {
            setData[setDataDictionary.fixaText.rawValue] = nil
            useDefaults.set(setData, forKey: dataPass.useDafaultKeyForSetData.rawValue)
        }
    }
}
