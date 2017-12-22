//
//  People+Say.m
//  CateforyDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "People+Say.h"

@implementation People (Say)

- (void)say
{
    /**
        分类中可以访问原来类中的成员变量 @public @protected @private
     */
    NSLog(@"category name:%@", self.name);
    NSLog(@"age:%ld", _age);
    NSLog(@"sex:%@", _sex);
    NSLog(@"weight:%f", _weight);
    
    NSLog(@"say category");
}

@end
