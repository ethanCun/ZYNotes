//
//  ViewController.m
//  Test
//
//  Created by macOfEthan on 2018/2/22.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"1");
    
    //在主线程中同步调用崩溃 造成死锁1 2 3
//    dispatch_sync(dispatch_get_main_queue(), ^{
//
//        sleep(3);
//
//        NSLog(@"2");
//    });
    
    
    //同步调用串行并行队列： 都是按顺序执行1 2 3
//    dispatch_sync(serialQueue, ^{
//
//        sleep(3);
//
//        NSLog(@"2");
//
//    });
//    dispatch_sync(concurrentQueue, ^{
//
//        sleep(3);
//
//        NSLog(@"2");
//    });
    
    
    //异步调用串行队列：不按顺序执行 结果为 1 3 2
//    dispatch_async(serialQueue, ^{
//
//        sleep(3);
//
//        NSLog(@"2");
//    });
    
    //异步调用并行队列：不按顺序执行 结果为 1 3 2
//    dispatch_async(concurrentQueue, ^{
//
//        sleep(3);
//
//        NSLog(@"2");
//    });
        
    NSLog(@"3");
}


@end
