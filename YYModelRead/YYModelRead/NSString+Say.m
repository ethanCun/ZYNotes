//
//  NSString+Say.m
//  YYModelRead
//
//  Created by macOfEthan on 17/12/26.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "NSString+Say.h"
#import <objc/runtime.h>

@implementation NSString (Say)

+ (void)load
{
    Method m1 = class_getInstanceMethod(self, @selector(stringByAppendingString:));
    Method m2 = class_getInstanceMethod(self, @selector(zy_stringByAppendingString:));
    method_exchangeImplementations(m1, m2);
    
    Method m3 = class_getClassMethod(self, @selector(stringWithString:));
    Method m4 = class_getClassMethod(self, @selector(zy_stringWithString:));
    
    method_exchangeImplementations(m3, m4);
}

+ (instancetype)zy_stringWithString:(NSString *)format
{
    NSString *ss = [@"拼接" stringByAppendingString:[format stringByAppendingString:@"&& "]];
    NSString *s = [self zy_stringWithString:ss];
    
    return s;
}

- (instancetype)zy_stringByAppendingString:(NSString *)string
{
    
    if (string.length == 0 || [string containsString:@"&"]) {
        
        string = @"拼接的字符串不合法";
    }
    
    NSString *s = [self zy_stringByAppendingString:string];
    
    return s;
}

@end
