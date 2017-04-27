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
    
    var clipBoard : String?
    var rowOfEditClip : Int?
    let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    var setData : Dictionary<String, Any?> = [:]
    var fixaTextFlg : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clipTextOutlet.delegate = self
        
        self.view.backgroundColor = viewPropaty.backgroundColor
        clipTextOutlet.backgroundColor = viewPropaty.cellColor
        buttonView(okButtonOutlet)
        buttonView(deleteButtonOutlet)
        buttonView(rowSetButtonOutlet)
        
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
            if let fixaText = setData[setDataDictionary.fixaText.rawValue] {
                if clipBoard == fixaText as? String {
                    rowSetButtonOutlet.setTitle("固定解除", for: .normal)
                    fixaTextFlg = true
                }
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
        saveClipBoard(theClipBoards)
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
        
        saveClipBoard(theClipBoards)
        navigationController?.popViewController(animated: true)
    }
    
    //表示行を先頭に固定するボタン
    @IBAction func fixaAction(_ sender: UIButton) {
        if fixaTextFlg {
            setData[setDataDictionary.fixaText.rawValue] = nil
        } else {
            setData[setDataDictionary.fixaText.rawValue] = clipBoard
            let clipBoards : [String]? = getClipboardFromUserData()
            guard var theClipBoards = clipBoards else {
                return
            }
            if let index = theClipBoards.index(of: clipBoard!) {
                theClipBoards.remove(at: index)
            }
            theClipBoards.insert(clipBoard!, at: 0)
            
            saveClipBoard(theClipBoards)
        }
        useDefaults.set(setData, forKey: dataPass.useDafaultKeyForSetData.rawValue)
        navigationController?.popViewController(animated: true)
    }
        
    func getClipboardFromUserData() -> [String]?{
        var clipBoards : [String]?
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoards = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]?
        }
        return clipBoards
    }
    
    @IBAction func tapBoardAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    func saveClipBoard(_ clipBoards : [String]) {
        
        useDefaults.set(clipBoards, forKey: dataPass.useDafaultKey.rawValue)
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
