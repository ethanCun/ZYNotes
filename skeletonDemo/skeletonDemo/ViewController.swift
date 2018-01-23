//
//  ViewController.swift
//  skeletonDemo
//
//  Created by macOfEthan on 2018/1/23.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit
import SkeletonView

class ViewController: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avatorView = UIImageView.init(frame: CGRect.init(x: 100, y: 84, width: 100, height: 100))
        avatorView.backgroundColor = UIColor.darkText
        self.view.addSubview(avatorView)
        
        avatorView.isSkeletonable = true
        
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        avatorView.showAnimatedGradientSkeleton(usingGradient: SkeletonDefaultConfig.gradient, animation: animation)
        
        let lab:UILabel = UILabel.init(frame: CGRect.init(x: 100, y: avatorView.frame.maxY+10, width: 100, height: 100))
        self.view.addSubview(lab)

        lab.numberOfLines = 3
        lab.lineBreakMode = .byCharWrapping
        lab.lastLineFillPercent = 50
        lab.showGradientSkeleton()
        
        let tableView:UITableView = UITableView.init(frame: CGRect.init(x: 100, y: lab.frame.maxY+10, width: 200, height: 200))
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.register(object_getClass(UITableViewCell()), forCellReuseIdentifier: "hehe")
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0) {
            
            lab.hideSkeleton()
            avatorView.hideSkeleton()
            lab.text = "lastLineFillPercentlastLineFillPercentlastLineFillPercentlastLineFillPercentlastLineFillPercent"
        }
        
        let lll:UILabel = UILabel.init(frame: CGRect.init(x: 100, y: tableView.frame.maxY+20, width: 100, height: 30))
        lll.text = "gghqqwq"
        lll.textColor = UIColor.red
        lll.font = UIFont.systemFont(ofSize: 19)
        self.view.addSubview(lll)
        
        lll.isSkeletonable = true
        lll.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0) {
            
            lll.hideSkeleton(reloadDataAfter: true)
            lll.text = "gghqqwq"
        }
        
        let ss:say = say()
        ss.sayhaha()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "hehe")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "hehe")
        }
        
        let ll:UILabel = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 50, height: 20))
        ll.text = "hhahahahah"
        ll.font = UIFont.boldSystemFont(ofSize: 15)
        ll.textColor = UIColor.red
        cell?.contentView.addSubview(ll)
        
        let img:UIImageView = UIImageView.init(frame: CGRect.init(x: 100, y: 20, width: 20, height: 20))
        img.backgroundColor = UIColor.red
        cell?.contentView.addSubview(img)
        
//        ll.showAnimatedGradientSkeleton()
        img.showAnimatedGradientSkeleton()
        
//        ll.isSkeletonable = true
        img.isSkeletonable = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5.0) {
            
//            ll.hideSkeleton()
            img.hideSkeleton()
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let s:seondViewController = seondViewController.init()
        self.present(s, animated: true) {
            
            print("succeed!")
        }
    }
    
    // MARK: - UITableViewDelegate, SkeletonTableViewDataSource
    func numSections(in collectionSkeletonView: UITableView) -> Int
    {
        return 1
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdenfierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    {
        return "hehe"
    }


}

