//
//  People+Say.h
//  CateforyDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "People.h"

@interface People (Say)
{
    //不能直接声明成员变量 编译期即报错
//    @public NSString *_province;
}

//运行时早不到setHeight:方法
@property (nonatomic, assign) float height;


@end
