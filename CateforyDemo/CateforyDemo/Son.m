//
//  Son.m
//  CateforyDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "Son.h"
////创建一个外部的匿名类/类扩展
#import "Son_Text.h"

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        NSLog(@"son");
        
        self.text = 111;
        NSLog(@"self.text = %ld", self.text);
        
        //子类中不能方位@private的成员变量 编译期就报错 category中可以
        NSLog(@"son name:%@", self.name);
        NSLog(@"age:%ld", _age);
        NSLog(@"sex:%@", _sex);
//        NSLog(@"weight:%f", _weight);
        
        NSLog(@"=========");
        
    }
    return self;
}

@end
