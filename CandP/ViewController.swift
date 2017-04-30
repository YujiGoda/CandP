//
//  ViewController.swift
//  CandP
//
//  Created by 合田佑司 on 2017/02/19.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var clipTable: UITableView!
    @IBOutlet weak var settingBarButtonOutlet: UIBarButtonItem!
    
    //クリップボード一覧
    var clipBoard : [String] = [String]()
    //保護中のクリップボードデータ一覧
    var fixaClipBoard : Array<String> = []
    //設定情報一覧
    var setData : Dictionary<String,Any?> = [:]
    let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    let board = UIPasteboard.general
    
    //ClipEditViewController遷移用
    var editClipBoard : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clipTable.delegate = self
        clipTable.dataSource = self
        
        //画面の背景色変更
        self.view.backgroundColor = viewPropaty.backgroundColor
        //テーブルの背景色変更
        self.clipTable.backgroundColor = viewPropaty.backgroundColor
        //セルの線を薄い白に変更
        self.clipTable.separatorColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.2)
        //セルのフォント変更
        if let font = viewPropaty.font {
            self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
        }
        
        //useDefaultに保存されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        //保護されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) != nil {
            fixaClipBoard = useDefaults.array(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) as! Array<String>
        }
        //useDefaultに保存されている設定情報を取得
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveClipBoard), name: NSNotification.Name.UIPasteboardChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.returnFormBackbround), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //useDefaultに保存されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        //保護されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) != nil {
            fixaClipBoard = useDefaults.array(forKey: dataPass.useDefaultKeyForFixaClipData.rawValue) as! Array<String>
        }
        //useDefaultに保存されている設定情報を取得
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        clipTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguePass.segue1.rawValue {
            let clipEditViewController: ClipEditViewController = segue.destination as! ClipEditViewController
            clipEditViewController.clipBoard = editClipBoard!
            clipEditViewController.rowOfEditClip = clipBoard.index(of: editClipBoard!)
        }
    }
    
    //バックグラウンドから戻る際に実行
    func returnFormBackbround() {
        //useDefaultに保存されているクリップボード一覧を取得
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        self.saveClipBoard()
        clipTable.reloadData()
    }
    
    //テーブルの行数設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clipBoard.count
    }
    
    //セルが選択された時、セルの値をクリップボードに設定
    //クリップボードに格納された値をテーブルのトップに移動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        board.setValue(clipBoard[indexPath.row], forPasteboardType: "public.text")
        clipTable.reloadData()
    }
    
    //テーブルのセルにuseDefaultに保存されているclipboard一覧を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = clipBoard[indexPath.row]
        if let font = viewPropaty.font {
            cell.textLabel?.font = font
        }
        //cell.textLabel?.shadowColor = UIColor.white
        cell.textLabel?.textColor = viewPropaty.cellTextColor
        return cell
    }
    
    //セルをスクロールさせた時に表示されるボタンの内容
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //編集ボタンの設定
        //押されると編集画面に遷移
        let editButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "編集") { (action, index) -> Void in
            //ClipEditViewController遷移用の変数に格納
            self.editClipBoard = self.clipBoard[indexPath.row]
            //編集テキストをiPhoneのクリップボードに設定
            self.board.setValue(self.clipBoard[indexPath.row], forPasteboardType: "public.text")
            self.performSegue(withIdentifier: seguePass.segue1.rawValue, sender: nil)
        }
        editButton.backgroundColor = UIColor.blue
        
        //削除ボタンの設定
        //押されるとそのセルの内容を配列:clipBoardから削除
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) in
            //削除対象テキストが保護対象であれば、保護一覧からも削除
            if let index = self.fixaClipBoard.index(of: self.clipBoard[index.row]) {
                self.fixaClipBoard.remove(at: index)
                self.useDefaults.set(self.fixaClipBoard, forKey: dataPass.useDefaultKeyForFixaClipData.rawValue)
            }
            checkFixaTextDelete(self.clipBoard[indexPath.row])
            self.clipBoard.remove(at: indexPath.row)
            self.clipTable.reloadData()
            self.useDefaults.set(self.clipBoard, forKey: dataPass.useDafaultKey.rawValue)
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [editButton, deleteButton]
    }
    
    func saveClipBoard() {
        if let clip = board.string {
            //クリップボードに値がある場合
            if fixaClipBoard.index(of: clip) != nil {
                //保護一覧にクリップボードの値が存在している場合、何もしない
            } else {
                //保護一覧にクリップボードの値が存在していない場合
                if let index = clipBoard.index(of: clip) {
                    //clipBoardの中に現在のクリップボードの値がある場合、削除
                    clipBoard.remove(at: index)
                }else {
                    //clipBoardの中に現在のクリップボードの値がない場合
                    if let saveNumber = setData[setDataDictionary.saveNumber.rawValue] as? Int {
                        //保存件数の最大件数が設定されている場合
                        if saveNumber == clipBoard.count {
                            //最大保存件数に達している場合、clipBoardのラスト行を削除
                            clipBoard.removeLast()
                        }
                    }
                }
                //保護一覧で領域外で先頭行に追加
                clipBoard.insert(clip, at: fixaClipBoard.count)
            }
            useDefaults.set(clipBoard, forKey: dataPass.useDafaultKey.rawValue)
        } else {
            //クリップボードに値がない場合
            print("no clipboard")
        }
    }
}

