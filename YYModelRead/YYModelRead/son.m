//
//  son.m
//  YYModelRead
//
//  Created by macOfEthan on 17/12/24.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "son.h"

//static NSString *s = @"111";

extern NSString * const AFNetworkingReachabilityDidChangeNotification;


@implementation son

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"%@", s);
        
        /**
         　　isKindOfClass来确定一个对象是否是一个类的成员，或者是派生自该类的成员搜索
         　　isMemberOfClass只能确定一个对象是否是当前类的成员
         */
        
        NSLog(@" %d  %d", [self isKindOfClass:[son class]],[self isMemberOfClass:[son class]]);

        NSLog(@" %d  %d", [self isKindOfClass:[people class]],[self isMemberOfClass:[people class]]);
        
        /**
         class:获取方法调用类名
         superclass:获取方法调用者的父类类名
         super:编译修饰符,不是指针,指向父类标志,
         本质还是拿到当前对象去调用父类的方法
         注意:super并不是拿到父类对象去调用父类方法
         */
        
        NSLog(@" %@, %@ %@ %@", [self class], [super class], [self superclass], [super superclass]);
        
        /**
         2016-12-26 10:06:32.992 YYModelRead[4013:223341]  1  1
         2016-12-26 10:06:32.992 YYModelRead[4013:223341]  1  0
         2016-12-26 10:06:32.992 YYModelRead[4013:223341]  son, son people people
         */
    }
    return self;
}

@end
