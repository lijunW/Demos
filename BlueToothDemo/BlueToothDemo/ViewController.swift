//
//  ViewController.swift
//  BlueToothDemo
//
//  Created by wanglijun on 2017/9/4.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

import UIKit
import CoreBluetooth
import Realm
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate {

    let rlm = try? Realm()
    
    let tableView = UITableView.init(frame: UIScreen.main.bounds, style: .grouped)
    
    // 1.创建管理中心
    var CBManager : CBCentralManager!
    
    var dataSourceArray = [Dictionary<String, Any>]()
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        CBManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : NSNumber.init(value: false)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CBManager = CBCentralManager.init(delegate: self, queue: DispatchQueue.main)
        
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self))
        if cell == nil{
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell.self))
        }
        let dic = dataSourceArray[indexPath.row]
        
        let RSSI = dic["RSSI"] as? NSNumber
        
        let per = dic["peripheral"] as? CBPeripheral
        cell?.textLabel?.text = per?.name
        cell?.detailTextLabel?.text = RSSI?.stringValue
        return cell!
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        NSLog("%@", central)
        switch central.state {
        case .poweredOn:
            NSLog("打开，可用");
            self.refresh(UIBarButtonItem())
            break;
        case .poweredOff:
            NSLog("可用，未打开");
            break;
        case .unsupported:
            NSLog("SDK不支持");
            break;
        case .unauthorized:
            NSLog("程序未授权");
            break;
        case .resetting:
            NSLog("CBCentralManagerStateResetting");
            break;
        case .unknown:
            NSLog("CBCentralManagerStateUnknown");
            break;
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]){
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?){
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?){
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        if peripheral.name == nil {
            return
        }
        
        NSLog("Discovered name:\(String(describing: peripheral.name)),identifier:\(peripheral.identifier),advertisementData:\(advertisementData),RSSI:\(RSSI)")
        if dataSourceArray.count == 0 {
            let dict = ["peripheral":peripheral,"RSSI":RSSI];
            dataSourceArray.append(dict)
        } else {
            var isExist = false
            
            for (index,dict) in dataSourceArray.enumerated() {
                let per = dict["peripheral"] as? CBPeripheral
                if per?.identifier.uuidString == peripheral.identifier.uuidString {
                    isExist = true
                    let dic = ["peripheral":peripheral,"RSSI":RSSI];
                    dataSourceArray[index] = dic
                }
            }
            
            if isExist == false {
                let dict = ["peripheral":peripheral,"RSSI":RSSI];
                dataSourceArray.append(dict)
            }
        }
        tableView.reloadData()
    }
    
}

