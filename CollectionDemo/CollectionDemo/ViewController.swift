//
//  ViewController.swift
//  CollectionDemo
//
//  Created by wanglijun on 2017/9/4.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var collectionView = { () -> UICollectionView in 
        let collect = UICollectionView.init(frame: UIScreen.main.bounds)
        collect.delegate = self as? UICollectionViewDelegate
        collect.dataSource = self as? UICollectionViewDataSource
        return collect;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
    }

}

