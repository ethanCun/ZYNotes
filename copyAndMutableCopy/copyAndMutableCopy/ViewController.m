//
//  ViewController.m
//  copyAndMutableCopy
//
//  Created by macOfEthan on 17/12/27.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = [NSArray arrayWithObjects:@"1", @"2", nil];
    NSMutableArray *mutArr = [NSMutableArray arrayWithObjects:@"3",@"4", nil];
    
    NSLog(@"%p, %p", arr, mutArr);
    
    id arrCopy = [arr copy];
    id arrMutableCopy = [arr mutableCopy];
    
    NSLog(@"arr %p %p %d %d %d %d %@ %@", arrCopy, arrMutableCopy, [arrCopy isKindOfClass:[NSArray class]], [arrMutableCopy isKindOfClass:[NSArray class]], [arrCopy isKindOfClass:[NSMutableArray class]], [arrMutableCopy isKindOfClass:[NSMutableArray class]], arrCopy, arrMutableCopy);
    
    /**
       0x60800003bb60, 0x60800004ae00
     arr 0x6080000330a0 0x600000049a50 1 1 0 1 (
     1,
     2
     ) (
     1,
     2
     
     结论：
     1.对不可变数组的copy操作是地址的引用（浅拷贝）,mutableCopy操作是深拷贝
     2.对不可变素组操作copy与mutableCopy后的对象都是不可变类型
     */
    
    id mutArrCopy = [mutArr copy];
    id mutArrMutableCopy = [mutArr mutableCopy];
    
    NSLog(@"mutArr %p %p %d %d %d %d %@ %@", mutArrCopy, mutArrMutableCopy, [mutArrCopy isKindOfClass:[NSArray class]], [mutArrMutableCopy isKindOfClass:[NSArray class]], [mutArrCopy isKindOfClass:[NSMutableArray class]], [mutArrMutableCopy isKindOfClass:[NSMutableArray class]], mutArrCopy, mutArrMutableCopy);
    
    /**
     结论：
     1.对可变数组的copy操作后的对象是不可变数组,mutableCopy操作可变数组；
     2.对可变素组操作copy与mutableCopy都是深拷贝；
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
