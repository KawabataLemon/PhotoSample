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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet private dynamic weak var imageView: UIImageView?
    
    // 画像をもどす
    @IBAction private dynamic func reloadImage(_ sender: Any) {
        
        self.imageView?.image = UIImage(named:"salmon.png")
    }

    // セピアを適応する
    @IBAction private dynamic func applySepia(_ sender: Any) {

        if let inputuiImage = self.imageView?.image {
            
            self.imageView?.image = FilterType.sepia.getOutputImage(image: inputuiImage)
        }
    }
    
    // モノクロにする
    @IBAction private dynamic func applyMono(_ sender: Any) {
    
        if let inputuiImage = self.imageView?.image {
            
            self.imageView?.image = FilterType.mono.getOutputImage(image: inputuiImage)
        }
    }
    
    // カスタムフィルタを適応する
    @IBAction private dynamic func applyCustom1(_ sender: Any) {
        
        
    }
    
    // カスタムフィルタを適応する
    @IBAction private dynamic func applyCustom2(_ sender: Any) {
        
        
    }
}

