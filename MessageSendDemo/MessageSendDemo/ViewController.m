//
//  ViewController.m
//  MessageSendDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     因为performSelector是运行时系统负责去找方法的，在编译时候不做任何校验；如果直接调用编译是会自动校验。
     */
    [[People new] performSelector:@selector(say) withObject:@"1111" afterDelay:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
