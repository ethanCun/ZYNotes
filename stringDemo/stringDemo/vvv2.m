//
//  vvv2.m
//  stringDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "vvv2.h"

@implementation vvv2

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"v2 hitText");
    
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"v2 pointInside");
    
    return [super pointInside:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
