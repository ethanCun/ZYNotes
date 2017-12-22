//
//  People.h
//  CateforyDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject
{
    @protected NSInteger _age;
    @public NSString *_sex;
    @private float _weight;
}

@property (nonatomic, copy) NSString *name;



@end
