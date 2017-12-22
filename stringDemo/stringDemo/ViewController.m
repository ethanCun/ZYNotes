//
//  ViewController.m
//  stringDemo
//
//  Created by macOfEthan on 17/12/21.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "vvv.h"
#import "vvv1.h"
#import "vvv2.h"
#import "vvv3.h"

@interface ViewController ()

@property (nonatomic,weak) id      weakPoint;
@property (nonatomic,assign) id    assignPoint;
@property (nonatomic,strong) id    strongPoint;

@property (nonatomic, strong) vvv *vv;


@property (nonatomic, strong) vvv1 *v1;
@property (nonatomic, strong) vvv2 *v2;
@property (nonatomic, strong) vvv3 *v3;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strongPoint = [NSDate date];
    NSLog(@"strong属性：%@",self.strongPoint);
    self.weakPoint = self.strongPoint;
    self.assignPoint = self.strongPoint;
    self.strongPoint = nil;
    NSLog(@"weak属性：%@",self.weakPoint);
//    NSLog(@"assign属性：%@",self.assignPoint);
    
//    UIApplication
//    UIViewController
//    [UIView appearance]
//    UIResponder
    
    _vv = [vvv new];
    [self.view addSubview:_vv];
    _vv.frame = CGRectMake(0, 0, 100, 100);
    _vv.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_vv addGestureRecognizer:tap];
    
    
    _v1 = [[vvv1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _v1.backgroundColor = [UIColor redColor];
    _v1.userInteractionEnabled = YES;
    [self.view addSubview:_v1];
    
    _v2 = [[vvv2 alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    _v2.backgroundColor = [UIColor greenColor];
    
    //拦截事件 交给父视图
//    _v2.userInteractionEnabled = NO;
//    _v2.alpha = 0.005;
//    _v2.frame = CGRectZero;
    
    [_v1 addSubview:_v2];
    
    _v3 = [[vvv3 alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
    _v3.backgroundColor = [UIColor orangeColor];
    [_v1 addSubview:_v3];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3:)];

    [_v1 addGestureRecognizer:tap1];
    [_v2 addGestureRecognizer:tap2];
    [_v3 addGestureRecognizer:tap3];

}

- (void)tap:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap");
}

- (void)tap1:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap1");
}

- (void)tap2:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap2");
}

- (void)tap3:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap3");
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"摸我干啥！");
//}
//// 手指移动就会调用这个方法
//// 这个方法调用非常频繁
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"哎呀，不要拽人家！");
//}
//// 手指离开屏幕时就会调用一次这个方法
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"手放开还能继续玩耍！");
//}


@end
