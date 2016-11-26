//
//  ViewController.swift
//  PhotoSample
//
//  Created by Kawabata Kazuki on 2016/11/24.
//  Copyright © 2016年 Kawabata Lemon. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
    }

    @IBOutlet private dynamic weak var imageView: UIImageView?
    
    // 画像をもどす
    @IBAction private dynamic func reloadImage(_ sender: Any) {
        
        self.imageView?.image = UIImage(named:"salmon.png")
    }

    // セピアを適応する
    @IBAction private dynamic func applySepia(_ sender: Any) {

        self.apply(type: .sepia)
    }
    
    // モノクロにする
    @IBAction private dynamic func applyMono(_ sender: Any) {
    
        self.apply(type: .mono)
    }
    
    // カスタムフィルタを適応する
    @IBAction private dynamic func applyCustom1(_ sender: Any) {
        
        self.apply(type: .custom1)
    }
    
    // カスタムフィルタを適応する
    @IBAction private dynamic func applyCustom2(_ sender: Any) {

        self.apply(type: .custom2)
    }
    
    private func apply(type: FilterType) {
        
        if let inputuiImage = self.imageView?.image {
            
            self.imageView?.image = type.getOutputImage(image: inputuiImage)
        }
    }
}

