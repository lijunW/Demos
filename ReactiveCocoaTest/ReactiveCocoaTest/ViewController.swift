//
//  ViewController.swift
//  ReactiveCocoaTest
//
//  Created by wanglijun on 2017/7/24.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

import UIKit
import ReactiveCocoa
import MJRefresh
import IJKMediaFramework

class ViewController: UIViewController {

    lazy var player : IJKFFMoviePlayerController = {
        let urls = NSURL.init(string: "rtmp://192.168.2.194/rtmplive/demo")
        let Options = IJKFFOptions.byDefault()
        var player = IJKFFMoviePlayerController.init(contentURL: urls! as URL!, with: Options!)
        
        let options : UIViewAutoresizing = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
        player?.view.autoresizingMask = options
        player?.scalingMode = .aspectFit
        player?.shouldAutoplay = true
        return player!
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        
        IJKFFMoviePlayerController.setLogReport(true)
        IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
        IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
        
        self.player.view.frame = self.view.bounds
        self.view.addSubview(player.view)
        
        self.view.autoresizesSubviews  = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.player.prepareToPlay()
    }
    
}

