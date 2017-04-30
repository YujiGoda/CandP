//
//  func.swift
//  CandP
//
//  Created by 合田佑司 on 2017/04/22.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import Foundation

let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!

func checkFixaTextDelete(_ deleteText : String) {
    
    var fixaClipBoard : Array<String> = []
    //useDefaultに保存されている設定情報を取得
    
    if useDefaults.object(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) != nil {
        fixaClipBoard = useDefaults.array(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) as! Array<String>
        if let index = fixaClipBoard.index(of: deleteText) {
            fixaClipBoard.remove(at: index)
            useDefaults.set(fixaClipBoard, forKey: dataPass.useDefaultKeyForFixaClipData.rawValue)
        }
    }
}
