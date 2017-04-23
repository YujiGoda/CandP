//
//  saveNnumberSetViewController.swift
//  CandP
//
//  Created by 合田佑司 on 2017/02/26.
//  Copyright © 2017年 YujiGoda. All rights reserved.
//

import UIKit

class saveNnumberSetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var saveNumberTableOutlet: UITableView!
    
    var useDefaults : UserDefaults = UserDefaults(suiteName: dataPass.useDafaultPass.rawValue)!
    var setData : Dictionary<String, Any?> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = viewPropaty.backgroundColor
        
        saveNumberTableOutlet.delegate = self
        saveNumberTableOutlet.dataSource = self
        
        //useDefaultに保存されている設定情報を取得
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        
        saveNumberTableOutlet.rowHeight = saveNumberTableOutlet.frame.size.height / 5.0

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if useDefaults.object(forKey: dataPass.useDafaultKeyForSetData.rawValue) != nil {
            setData = useDefaults.dictionary(forKey: dataPass.useDafaultKeyForSetData.rawValue) as! Dictionary<String, Any?>
        }
        saveNumberTableOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    //保存件数一覧の表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = viewPropaty.backgroundColor
        cell.textLabel?.font = viewPropaty.font
        cell.textLabel?.textColor = viewPropaty.cellTextColor
        
        switch indexPath.row {
        case 0:
            setCorrectNumber(cell, selectNumber: 10)
            cell.textLabel?.text = "10件"
        case 1:
            setCorrectNumber(cell, selectNumber: 25)
            cell.textLabel?.text = "25件"
        case 2:
            setCorrectNumber(cell, selectNumber: 50)
            cell.textLabel?.text = "50件"
        case 3:
            setCorrectNumber(cell, selectNumber: 75)
            cell.textLabel?.text = "75件"
        case 4:
            setCorrectNumber(cell, selectNumber: 100)
            cell.textLabel?.text = "100件"
        default:
            break
        }
        return cell
    }
    
    func setCorrectNumber(_ cell : UITableViewCell, selectNumber : Int) {
        if let correctSaveNumber = setData[setDataDictionary.saveNumber.rawValue] as? Int{
            if correctSaveNumber == selectNumber {
                cell.backgroundColor = UIColor(red: 0.67, green: 0.77, blue: 0.8, alpha: 1.0)
            }
        }
    }
    
    //保存件数の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            setSaveNumber(selectNumber: 10)
        case 1:
            setSaveNumber(selectNumber: 25)
        case 2:
            setSaveNumber(selectNumber: 50)
        case 3:
            setSaveNumber(selectNumber: 75)
        case 4:
            setSaveNumber(selectNumber: 100)
        default:
            break
        }
        saveNumberTableOutlet.reloadData()
    }
    
    func setSaveNumber(selectNumber : Int) {
        setData[setDataDictionary.saveNumber.rawValue] = selectNumber
        useDefaults.set(setData, forKey: dataPass.useDafaultKeyForSetData.rawValue)
    }

    

}
