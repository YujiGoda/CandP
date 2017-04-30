//
//  Struct.swift
//  CandP
//
//  Created by 合田佑司 on 2017/02/25.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import Foundation
import UIKit

struct viewPropaty {
    static let backgroundColorred : CGFloat = 0.95
    static let backgroundColorbule : CGFloat = 0.95
    static let backgroundColorgreen : CGFloat = 0.95
    
    //全画面のバックグランドカラー
    static let backgroundColor : UIColor = UIColor(red: viewPropaty.backgroundColorred, green: viewPropaty.backgroundColorgreen, blue: viewPropaty.backgroundColorbule, alpha: 1.0)
    //全画面のセルのテキストカラー
    static let cellTextColor : UIColor = UIColor(red: 0.074, green: 0.29, blue: 0.41, alpha: 1.0)
    //全画面のセルのカラー
    static let cellColor : UIColor = UIColor(red: 0.92, green: 0.95, blue: 0.95, alpha: 0.5)
    //barのタイトルのカラー
    static let titleColor : UIColor = UIColor.black
    //全画面のフォント
    static let font = UIFont(name: "HiraKakuProN-W6", size: 15)
}

enum dataPass : String {
    case useDafaultPass = "group.CandPClipData"
    case useDafaultKeyForSetData = "setData"
    case useDafaultKey = "clipboard"
    case useDefaultKeyForFixaClipData = "fixaClipData"
}

enum seguePass : String {
    case segue1 = "goEditClip"
    case segue2 = "goSaveNumberSetView"
}

enum setDataDictionary : String {
    case fixaText = "fixaText"
    case saveNumber = "saveNumber"
    case onOffWidget = "onOffWidget"
}

func buttonView(_ buttonOutlet: UIButton){
    buttonOutlet.layer.cornerRadius = 20.0
    buttonOutlet.layer.shadowOpacity = 0.9
    buttonOutlet.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
    buttonOutlet.layer.shadowRadius = 2.0
    buttonOutlet.backgroundColor = UIColor.white
    buttonOutlet.layer.shadowColor = UIColor.black.cgColor
    buttonOutlet.titleLabel?.textColor = viewPropaty.cellTextColor
    buttonOutlet.titleLabel?.font = viewPropaty.font
    
}

