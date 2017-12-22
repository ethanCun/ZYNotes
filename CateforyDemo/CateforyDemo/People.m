//
//  People.m
//  CateforyDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>

//分类(category)和类扩展(extension)的关系
/**
 1.类扩展(extension）是category的一个特例，有时候也被称为匿名分类。他的作用是为一个类添加一些私有的成员变量和方法。
 2.类扩展能写点啥？和分类不同，类扩展即可以声明成员变量又可以声明方法。
 3.承自UIViewController的ViewController和继承自NSObject的类有什么不同么? 前者创建时默认就有类扩展了
 4.类扩展可以定义在.m文件中，这种扩展方式中定义的变量都是私有的，也可以定义在.h文件中，这样定义的代码就是共有的，类扩展在.m文件中声明私有方法是非常好的方式。
 */
@interface People ()
{
    NSInteger _example1;
}

@property (nonatomic, assign) NSInteger example2;

- (void)thisMethodMustToImplemetation;

@end

@implementation People

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, &"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, &"name");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _age = 100;
        _sex = @"man";
        _weight = 100.0;
//        self.name = @"zhangsan";
    }
    return self;
}

- (void)say
{
    NSLog(@"say inner");
}

@end
