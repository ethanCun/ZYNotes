//
//  ViewController.m
//  Test11
//
//  Created by macOfEthan on 2018/2/23.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "GreenView.h"
#import <AFNetworking.h>
#import <libkern/OSAtomic.h>

@interface ViewController ()

@property (nonatomic, strong) CALayer *redLayer;
@property (nonatomic, strong) GreenView *greenView;


@end

@implementation ViewController

#define url1 @"http://guangdiu.com/api/getranklist.php"
#define url2 @"https://wangclub.herokuapp.com/getListViewData"

#pragma mark - Dispatch_semapher_t处理多个异步任务完成之后刷新UI界面
- (void)testChangeUIAfterManyAsyncPostsWithSemphre
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSArray *urls = @[url1, url2, url1, url2,url1, url2,url1, url2];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    for (NSInteger i=0; i<urls.count; i++) {
        
        dispatch_async(queue, ^{
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
            sleep(2);
            
            [manager POST:urls[i] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"%@ finish", urls[i]);
                dispatch_semaphore_signal(sema);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@ finish", urls[i]);
                dispatch_semaphore_signal(sema);
            }];
        });
    }
    
    dispatch_group_async(group, queue, ^{
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            sleep(2);
            
            NSLog(@"sema 完成");
            
            NSLog(@"%@ %d",self.redLayer, [NSThread isMainThread]);
            
            self.view.backgroundColor = [UIColor lightGrayColor];
        });
        
        dispatch_semaphore_signal(sema);
    });
}


#pragma mark - dispatch_group_notify处理多个异步请求之后 刷新UI界面
- (void)testChangeUIAfterManyAsyncPostsWithGroup
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    dispatch_group_t group = dispatch_group_create();
    
    NSArray *urls = @[url1, url2, url1, url2,url1, url2,url1, url2];
    
    //创建好任务后将任务加入任务组的子线程中
    //dispatch_group_enter与dispatch_group_leave必须成对出现
    for (NSInteger i=0; i<urls.count; i++) {
        
        dispatch_group_enter(group);
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [manager POST:urls[i] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"%@ finish", urls[i]);
                dispatch_group_leave(group);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@ finish", urls[i]);
                dispatch_group_leave(group);
            }];
        });
        
    }
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        sleep(2);

        NSLog(@"更新UI");
        
        self.view.backgroundColor = [UIColor blueColor];
    });
}

#pragma mark - OSSpinLock
- (void)testChangeUIAfterManyAsyncPostsWithOSSpinLock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSArray *urls = @[url1, url2, url1, url2,url1, url2,url1, url2];
    
    //导入#import < libkern/OSAtomic.h >
    __block OSSpinLock lock = OS_SPINLOCK_INIT;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSInteger i=0; i<urls.count; i++) {
            
            OSSpinLockLock(&lock);

            sleep(2);

            [manager POST:urls[i] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"%@ finish", urls[i]);
                OSSpinLockUnlock(&lock);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@ finish", urls[i]);
                OSSpinLockUnlock(&lock);

            }];
            
        }
    });
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testChangeUIAfterManyAsyncPostsWithOSSpinLock];

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer];
    self.redLayer = layer;
    
    layer.shadowOpacity = 0.5;
    layer.shadowColor = [UIColor brownColor].CGColor;
    layer.shadowOffset = CGSizeMake(55, 55);
    layer.shadowRadius = 50;
    
    //设置阴影的图片
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:layer.bounds];
    layer.shadowPath = path.CGPath;
    
    GreenView *testV1 = [[GreenView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    testV1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testV1];
    
    GreenView *testV = [[GreenView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testV];
    self.greenView = testV;
    
    #pragma mark - 点击移动端的图片实例
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(50, 400)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 30;
    [testV.layer addAnimation:animation forKey:@"center"];

//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(50, 50)],[NSValue valueWithCGPoint:CGPointMake(50, 400)]];
//    animation.repeatCount = MAXFLOAT;
//    animation.duration = 30;
//    [testV.layer addAnimation:animation forKey:@"center"];
    
//    [UIView animateWithDuration:30 animations:^{
//
//        testV.transform = CGAffineTransformMakeTranslation(50, 400);
//    }];
    
}


#if 0
//判断一个点是否在视图里面
//方法1：转换坐标(convertPoint:fromLayer)和包含当下坐标点（containsPoint:）
//方法2：使用hitTest :来返回触摸点的layer来判断，从而响应事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint pp =[touch locationInView:self.view];
    
    CALayer *layer = [self.view.layer hitTest:pp];
    
    if (layer == self.redLayer) {
        
        NSLog(@"点击了红色的layer");
    }else if(layer == self.greenView.layer){
        
        NSLog(@"点击了绿色的layer");
    }
    

    
//    CGPoint ppInTest = [self.view.layer convertPoint:pp toLayer:self.redLayer];
//    NSLog(@"%d", [self.redLayer containsPoint:ppInTest]);
}
#endif


@end
