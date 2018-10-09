//
//  ViewController.swift
//  内存对齐2
//
//  Created by chenzhengying on 2018/9/21.
//  Copyright © 2018年 canzoho. All rights reserved.
//

import UIKit

struct Point1 {
    var a: Double?
    var b = 0
}

struct Point2 {
    var b = 0
    var a: Double?
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Double? size = \(MemoryLayout<Double?>.size)")
        print("Int size = \(MemoryLayout<Int>.size)")
        
        print("p1 :size = \(MemoryLayout<Point1>.size) align = \(MemoryLayout<Point1>.alignment) stride = \(MemoryLayout<Point1>.stride)")
        
        print("p2 :size = \(MemoryLayout<Point2>.size) align = \(MemoryLayout<Point2>.alignment) stride = \(MemoryLayout<Point2>.stride)")
        
        /*
         Double? size = 9
         Int size = 8
         p1 :size = 24 align = 8 stride = 24
         p2 :size = 17 align = 8 stride = 24
         */
        
        //我算出来是Point占24 Point占18 确实第二种占用少 但是为什么在iphone7模拟器上输出是一样的
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

