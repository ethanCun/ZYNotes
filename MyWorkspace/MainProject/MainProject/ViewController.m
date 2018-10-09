//
//  ViewController.m
//  MainProject
//
//  Created by chenzhengying on 2018/10/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "ViewController.h"
#import "SupportLibrary.h"
#import "DynamicLibrary/DynamicLibrary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SupportLibrary sayHello];
    [TestClass aTest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
