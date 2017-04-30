//
//  ClipEditViewController.swift
//  CandP
//
//  Created by 合田佑司 on 2017/02/19.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import UIKit

class ClipEditViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var clipTextOutlet: UITextView!{
        didSet {
            clipTextOutlet.text = clipBoard
        }
    }
    @IBOutlet weak var okButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var rowSetButtonOutlet: UIButton!
    
    
    //編集中のテキスト
    var clipBoard : String?
    //編集中の一覧のクリップボード一覧上のインデックス
    var rowOfEditClip : Int?
    //保護中のクリップボードデータ一覧
    var fixaClipBoard : Array<String> = []
    //編集中のテキストが保護中の場合、一覧のインデックスを格納
    var indexFixaClipBoard : Int?
    //userDefaultのパス設定
    let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    //iPhoneのクリップボード
    let board = UIPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clipTextOutlet.delegate = self
        
        self.view.backgroundColor = viewPropaty.backgroundColor
        clipTextOutlet.backgroundColor = viewPropaty.cellColor
        buttonView(okButtonOutlet)
        buttonView(deleteButtonOutlet)
        buttonView(rowSetButtonOutlet)
        
        if useDefaults.object(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) != nil {
            fixaClipBoard = useDefaults.array(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) as! Array<String>
            if let index = fixaClipBoard.index(of: clipBoard!) {
                rowSetButtonOutlet.setTitle("固定解除", for: .normal)
                indexFixaClipBoard = index
            }
        }
    }
    
    //修正完了ボタン
    @IBAction func okAction(_ sender: UIButton) {
        let clipBoards : [String]? = getClipboardFromUserData()
        guard var theClipBoards =  clipBoards else {
            return
        }
        
        theClipBoards[rowOfEditClip!] = clipTextOutlet.text
        useDefaults.set(theClipBoards, forKey: dataPass.useDafaultKey.rawValue)
        navigationController?.popViewController(animated: true)
    }
    
    //保存内容削除ボタン
    @IBAction func deleteAction(_ sender: UIButton) {
        let clipBoards : [String]? = getClipboardFromUserData()
        guard var theClipBoards =  clipBoards else {
            return
        }
        
        checkFixaTextDelete(clipBoard!)
        theClipBoards.remove(at: rowOfEditClip!)
        
        useDefaults.set(theClipBoards, forKey: dataPass.useDafaultKey.rawValue)
        navigationController?.popViewController(animated: true)
    }
    
    //表示行を先頭に固定するボタン
    @IBAction func fixaAction(_ sender: UIButton) {
        let clipBoards : [String]? = getClipboardFromUserData()
        
        //userDefaultからクリップボードデータ一覧の取得に失敗した場合、エラーを出力してreturn
        guard var theClipBoards = clipBoards else {
            print("error, cannot get the clipBoard Data")
            return
        }
        
        if indexFixaClipBoard != nil {
            //保護されている場合
            //保護一覧から削除してクリップボード一覧の表示位置を保護されている行から保護されていない行まで下げる
            fixaClipBoard.remove(at: indexFixaClipBoard!)
            theClipBoards.remove(at: rowOfEditClip!)
            theClipBoards.insert(clipBoard!, at: fixaClipBoard.count)
        } else {
            //保護されていない場合
            //保護一覧についか
            fixaClipBoard.append(clipBoard!)
        }
        useDefaults.set(theClipBoards, forKey: dataPass.useDafaultKey.rawValue)
        useDefaults.set(fixaClipBoard, forKey: dataPass.useDefaultKeyForFixaClipData.rawValue)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapBoardAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func getClipboardFromUserData() -> [String]?{
        var clipBoards : [String]?
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoards = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]?
        }
        return clipBoards
    }

    //returnキーを押した時にキーボードを隠す
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            clipTextOutlet.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
    

}
