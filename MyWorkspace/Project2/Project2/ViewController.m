//
//  ViewController.m
//  Project2
//
//  Created by chenzhengying on 2018/10/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "ViewController.h"
#import <YYModel.h>
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [NSObject yy_modelWithJSON:@""];
    
//    [[AFHTTPSessionManager manager] POST:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
