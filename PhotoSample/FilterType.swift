//
//  FilterType.swift
//  PhotoSample
//
//  Created by Kawabata Kazuki on 2016/11/24.
//  Copyright © 2016年 Kawabata Lemon. All rights reserved.
//

import UIKit
import CoreImage

//
// アプリで扱うフィルター
//
enum FilterType: Int {
    
    case sepia          // セピアフィルタ
    case mono           // 白黒フィルタ
    case custom1        // カスタムフィルタ
    case custom2        // カスタムフィルタ
 
    // フィルター名
    var name: String {
        
        switch self {
        case .sepia:
            
            return "CISepiaTone"

        case .mono:
            
            return "CIColorMonochrome"
            
        default:
            return ""
        }
    }

    // アウトプット画像を取得する
    func getOutputImage(image: UIImage) -> UIImage? {
        
        switch self {
        case .sepia,.mono:
            
            let inputImage = CIImage(image: image)
            let filter = CIFilter(name: self.name,withInputParameters: ["inputIntensity": 1.0])
            filter?.setValue(inputImage, forKey: "inputImage")

            if let outputImage = filter?.outputImage {
                
                let ciContext = CIContext(options: nil)
                let cgImage = ciContext.createCGImage(outputImage, from: inputImage!.extent)
                return UIImage(cgImage: cgImage!)
            } else {
                
                return nil
            }

            
        default:
            return nil
        }
    }
}
