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

    // アウトプット画像を取得する
    public func getOutputImage(image: UIImage) -> UIImage? {
        
        switch self {
            
        case .sepia,.mono:
            
            // 入力画像
            let inputImage = CIImage(image: image)
            
            // フィルターを作成
            let filter = CIFilter(name: self.name,withInputParameters: ["inputIntensity": 1.0])
            
            // 入力画像を渡す
            filter?.setValue(inputImage, forKey: "inputImage")

            // 出力画像はCIImage
            guard let outputImage = filter?.outputImage else {
                
                return nil
            }
            
            // CIContextからCGImageを作成し
            let ciContext = CIContext(options: nil)
            let cgImage = ciContext.createCGImage(outputImage, from: inputImage!.extent)
            
            // UIImageにもどす
            return UIImage(cgImage: cgImage!)
            
        case .custom1, .custom2:

            // リソース内のshaderファイルを開く
            let kernelStr = try! String(contentsOfFile: Bundle.main.path(forResource: self.name, ofType: "cikernel")!, encoding: String.Encoding.utf8)
            
            // 入力画像
            let inputImage = CIImage(image: image)

            guard let input = inputImage else {
                
                return nil
            }
            
            print("cikernel file string: \(kernelStr)")

            // custom1はCIWarpKernelのものをつかっています
            if self == .custom1 {
                
                let warpKernel = CIWarpKernel(string: kernelStr) // 座標をいじるカーネルはこちら

                guard let outputImage = warpKernel?.apply(withExtent: input.extent, roiCallback: {

                    // 処理後の画像のRectangleを計算しています。
                    // サンプルの画像ではレクタングルなので回転を行なってもそのままですがスケールなどだとRectを変更して返す必要があります
                    index,rect in
                    
                    return rect
                    
                }, inputImage: input, arguments: []) else { return nil }
                
                // CIContextからCGImageを作成し
                let ciContext = CIContext(options: nil)
                let cgImage = ciContext.createCGImage(outputImage, from: inputImage!.extent)
                
                // UIImageにもどす
                return UIImage(cgImage: cgImage!)

            // custom2はCIColorKernelのものをつかっています
            } else {

                let inputWidth = image.size.width

                let colorKernel = CIColorKernel(string: kernelStr) // 色をいじるカーネルはこちら
                
                // 色を変えるだけなのでRectのコールバックは必要ありません
                guard let outputImage = colorKernel?.apply(withExtent: input.extent,arguments: [input,inputWidth]) else { return nil }
                
                // CIContextからCGImageを作成し
                let ciContext = CIContext(options: nil)
                let cgImage = ciContext.createCGImage(outputImage, from: inputImage!.extent)
                
                // UIImageにもどす
                return UIImage(cgImage: cgImage!)
            }
        }
    }
}
