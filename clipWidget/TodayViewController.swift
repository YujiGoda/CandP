//
//  TodayViewController.swift
//  clipWidget
//
//  Created by 合田佑司 on 2017/02/19.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
    
    let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    let board = UIPasteboard.general                                                    //クリップボードのプロパティー
    
    @IBOutlet weak var clipTable: UITableView!
    
    var clipBoard : [String] = [String]()
    var setData : Dictionary<String, Any?> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clipTable.delegate = self
        clipTable.dataSource = self
        
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        
        //テーブルのセルラインの右側スペース幅を0にする
        self.clipTable.layoutMargins = UIEdgeInsets.zero
        
        //テーブルの高さを200に設定
        self.clipTable.frame.size.height = 200
        
        if let onOff = setData[setDataDictionary.onOffWidget.rawValue] as? Bool {
            //widget表示有無の設定がある場合
            if onOff {
                //widget非表示設定の場合、テーブルを非表示にする
                clipTable.isHidden = true
                self.preferredContentSize.height = 1
            } else {
                clipTable.isHidden = false
                self.preferredContentSize.height = 200
            }
        }
        saveClipBoard()
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveClipBoard), name: NSNotification.Name.UIPasteboardChanged, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        if let onOff = setData[setDataDictionary.onOffWidget.rawValue] as? Bool {
            //widget表示有無の設定がある場合
            if onOff {
                //widget非表示設定の場合、テーブルを非表示にする
                clipTable.isHidden = true
                self.preferredContentSize.height = 1
            } else {
                clipTable.isHidden = false
                self.preferredContentSize.height = 200
            }
        }
        //clipTable.frame = self.accessibilityFrame
        saveClipBoard()
        clipTable.reloadData()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        clipTable.reloadData()
        completionHandler(NCUpdateResult.newData)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clipBoard.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = clipBoard[indexPath.row]
        cell.textLabel!.textColor = UIColor.white
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        board.setValue(clipBoard[indexPath.row], forPasteboardType: "public.text")
        clipTable.reloadData()
    }
    
    func saveClipBoard() {
        if let clip = board.string {
            //クリップボードに値がある場合
            if let fixaText = setData[setDataDictionary.fixaText.rawValue] as? String {
                //固定行の設定がある場合
                if board.string != fixaText{
                    //固定行の値が現在のクリップボードの値と等しい場合
                    if let index = clipBoard.index(of: clip) {
                        //clipBoardの中に現在のクリップボードの値がある場合、削除
                        clipBoard.remove(at: index)
                    } else {
                        //clipBoardの中に現在のクリップボードの値がない場合
                        if let saveNumber = setData[setDataDictionary.saveNumber.rawValue] as? Int {
                            //保存件数の最大件数が設定されている場合
                            if saveNumber == clipBoard.count {
                                //最大保存件数に達している場合、clipBoardのラスト行を削除
                                clipBoard.removeLast()
                            }
                        }
                    }
                    //固定行の設定がある場合、clipBoardの2行目に値をinsert
                    clipBoard.insert(clip, at: 1)
                }
            } else {
                //固定行の設定がない場合
                if let index = clipBoard.index(of: clip) {
                    //固定行の値が現在のクリップボードの値と等しい場合
                    clipBoard.remove(at: index)
                } else {
                    //clipBoardの中に現在のクリップボードの値がない場合
                    if let saveNumber = setData[setDataDictionary.saveNumber.rawValue] as? Int {
                        if saveNumber == clipBoard.count {
                            clipBoard.removeLast()
                        }
                    }
                }
                //固定行の設定がない場合、clipBoardの1行目に値をinsert
                clipBoard.insert(clip, at: 0)
            }
            useDefaults.set(clipBoard, forKey: dataPass.useDafaultKey.rawValue)
        } else {
            //クリップボードに値がない場合
            print("no clipboard")
        }
    }
    
}
