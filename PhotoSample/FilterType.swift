//
//  FilterType.swift
//  PhotoSample
//
//  Created by Kawabata Kazuki on 2016/11/24.
//  Copyright © 2016年 Kawabata Lemon. All rights reserved.
//

import UIKit
import CoreImage

typealias Filter = (CIImage) -> CIImage?

//
// アプリで扱うフィルター
//
enum FilterType: Int {
    
    case sepia          // セピアフィルタ
    case mono           // 白黒フィルタ
    case custom1        // カスタムフィルタ
    case custom2        // カスタムフィルタ
 
    // フィルター名(カスタムものはファイル名)
    private var name: String {
        
        switch self {
        case .sepia:
            
            return "CISepiaTone"

        case .mono:
            
            return "CIColorMonochrome"
            
        case .custom1:
            return "custom1"

        case .custom2:
            return "custom2"

        }
    }

    var filter: Filter {
        
        switch self {
        case .sepia, .mono:
            return {
                img in
                
                // フィルターを作成
                let filter = CIFilter(name: self.name,withInputParameters: ["inputIntensity": 1.0])
                
                // 入力画像を渡す
                filter?.setValue(img, forKey: "inputImage")
                
                return filter?.outputImage
            }
        case .custom1:
            return {
                
                img in
                
                // リソース内のshaderファイルを開く
                let kernelStr = try! String(contentsOfFile: Bundle.main.path(forResource: self.name, ofType: "cikernel")!, encoding: String.Encoding.utf8)
                
                let warpKernel = CIWarpKernel(string: kernelStr) // 座標をいじるカーネルはこちら
                
                return warpKernel?.apply(withExtent: img.extent, roiCallback: {
                    
                    // 処理後の画像のRectangleを計算しています。
                    // サンプルの画像ではレクタングルなので回転を行なってもそのままですがスケールなどだとRectを変更して返す必要があります
                    index,rect in
                    
                    return rect
                    
                }, inputImage: img, arguments: [])
            }
            
        case .custom2:
            return {
                
                img in
                
                // リソース内のshaderファイルを開く
                let kernelStr = try! String(contentsOfFile: Bundle.main.path(forResource: self.name, ofType: "cikernel")!, encoding: String.Encoding.utf8)
                
                let inputWidth = img.extent.width
                
                let colorKernel = CIColorKernel(string: kernelStr) // 色をいじるカーネルはこちら
                
                // 色を変えるだけなのでRectのコールバックは必要ありません
                return colorKernel?.apply(withExtent: img.extent,arguments: [img,inputWidth])
            }
        }
    }
}
