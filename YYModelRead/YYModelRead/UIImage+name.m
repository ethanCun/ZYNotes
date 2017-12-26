//
//  UIImage+name.m
//  YYModelRead
//
//  Created by macOfEthan on 17/12/26.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import <objc/message.h>
#import "UIImage+name.h"

@implementation UIImage (name)

+ (void)load
{
    Method m1 = class_getClassMethod(self, @selector(imageNamed:));
    Method m2 = class_getClassMethod(self, @selector(zy_imageNamed:));
    
    method_exchangeImplementations(m1, m2);
}

+ (instancetype)zy_imageNamed:(NSString *)name
{
    UIImage *img = [self zy_imageNamed:name];
    
    NSLog(@"ssssueed");
    
    return img;
}

@end
