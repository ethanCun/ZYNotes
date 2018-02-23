//
//  GreenView.m
//  Test11
//
//  Created by macOfEthan on 2018/2/23.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

#import "GreenView.h"

@interface GreenView()

@property (nonatomic, strong) UIView *redView;

@end

@implementation GreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        redView.backgroundColor = [UIColor redColor];
        redView.userInteractionEnabled = YES;
        [self addSubview:redView];
        
        self.redView = redView;        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    CGPoint pp = [touches.anyObject locationInView:self];
    
    if ([self.redView.layer.presentationLayer hitTest:pp]) {
        
        NSLog(@"点击了移动的layer");
        
    }else{
        
        NSLog(@"移动的layer没有响应点击事件");
        
    }
}


@end
