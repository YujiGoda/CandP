//
//  SettingViewController.swift
//  CandP
//
//  Created by 合田佑司 on 2017/02/25.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var settingTable: UITableView!
    
    var numberOfSection : Array<Int> = [3, 1]
    //メニューの内容
    let setMenu = [["保存件数", "widgetへの一覧表示", "macとの同期"], ["保存一覧の削除"]]
    var setData : Dictionary<String, Any?> = [:]
    let useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = viewPropaty.backgroundColor
        self.settingTable.sectionIndexColor = viewPropaty.backgroundColor
        settingTable.delegate = self
        settingTable.dataSource = self
        
        //navigationBarのボタンのフォント変更
        if let font = viewPropaty.font {
         self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
        }
        //useDefaultに保存されている設定情報を取得
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        
        settingTable.rowHeight = settingTable.frame.size.height / 5
        // Do any additional setup after loading the view.
    }
    
    //セクションの数 = 2
    func numberOfSections(in tableView: UITableView) -> Int {
        return setMenu.count
    }
    
    //セクションごとの数
    //第一セクション = 5
    //第二セクション = 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfSection[section]
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return settingTable.frame.size.height / 5.0
        } else {
            return 0.0
        }
    }
    
    //セルのデータ
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = viewPropaty.cellColor
        cell.textLabel?.font = viewPropaty.font
        cell.textLabel?.textColor = viewPropaty.cellTextColor
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                //cell.textLabel?.text = "保存件数"
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            case 1:
                let onoffSwitch = UISwitch()
                if let onoff = setData[setDataDictionary.onOffWidget.rawValue] as? Bool {
                    onoffSwitch.isOn = onoff
                } else {
                    onoffSwitch.isOn = false
                }
                onoffSwitch.addTarget(self, action: #selector(SettingViewController.onoffWidgetAction), for: UIControlEvents.valueChanged)
                cell.accessoryView = onoffSwitch
                //cell.textLabel?.text = "widgetへの一覧表示"
            case 2:
                let onoffSwitch = UISwitch()
                cell.accessoryView = onoffSwitch
                //cell.textLabel?.text = "macとの同期"
            default:
                break
        }}
        cell.textLabel?.text = setMenu[indexPath.section][indexPath.row]
    

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {               //【保存件数】を押した時
            performSegue(withIdentifier: seguePass.segue2.rawValue, sender: nil)
        } else if (indexPath.section == 1 && indexPath.row == 0) {      //【保存一覧削除】を押した時
            let ac = UIAlertController(title: "保存一覧の削除", message: nil, preferredStyle: .alert)
            ac.addAction((UIAlertAction(title: "OK", style: .default, handler: deleteClip)))
            ac.addAction((UIAlertAction(title: "Cancel", style: .default, handler: nil)))
            present(ac, animated: true, completion: nil)
        }
    }
    
    //保存一覧削除関数
    func deleteClip(action: UIAlertAction!) {
        var clipBoard : [String] = [String]()
        if useDefaults.object(forKey: dataPass.useDafaultKey.rawValue) != nil {
            clipBoard = useDefaults.array(forKey: dataPass.useDafaultKey.rawValue) as! [String]
        }
        clipBoard.removeAll()
        setData[setDataDictionary.fixaText.rawValue] = nil
        useDefaults.set(clipBoard, forKey: dataPass.useDafaultKey.rawValue)
        useDefaults.set(setData, forKey: dataPass.useDafaultKeyForSetData.rawValue)
        
        let ac = UIAlertController(title: "保存一覧の削除", message: "削除しました", preferredStyle: .alert)
        ac.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
        present(ac, animated: true, completion: nil)
    }
    
    func onoffWidgetAction(sender : UISwitch) {
        setData[setDataDictionary.onOffWidget.rawValue] = sender.isOn
        useDefaults.set(setData, forKey: dataPass.useDafaultKeyForSetData.rawValue)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
