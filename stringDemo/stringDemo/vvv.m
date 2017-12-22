//
//  vvv.m
//  stringDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "vvv.h"

@implementation vvv

#if 1

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"vvv hitText");
    
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"vvv pointInside");
    
    return [super pointInside:point withEvent:event];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"begin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
#pragma mark - 视图跟随手指移动demo
    CGPoint currentLocation = [touches.anyObject locationInView:self];
    CGPoint previousLocation = [touches.anyObject previousLocationInView:self];
    
    NSLog(@"currentLocation  = %@", NSStringFromCGPoint(currentLocation));
    NSLog(@"previousLocation  = %@", NSStringFromCGPoint(previousLocation));

    CGFloat offsetX = currentLocation.x - previousLocation.x;
    CGFloat offsetY = currentLocation.y - previousLocation.y;
    
    self.frame = CGRectMake(self.frame.origin.x+offsetX, self.frame.origin.y+offsetY, self.frame.size.width, self.frame.size.height);
    
    //上下左右限制
    NSLog(@"fff  = %@", NSStringFromCGRect(self.frame));
    CGRect frame = self.frame;
    if (CGRectGetMinY(self.frame) <= 0) {
        
        if (CGRectGetMinX(self.frame) <= 0) {
            
            //左上角角落处
            frame.origin.x = 0;
        }else if (CGRectGetMaxX(self.frame) >= [UIScreen mainScreen].bounds.size.width){
            
            //右上角
            frame.origin.x = [UIScreen mainScreen].bounds.size.width-CGRectGetWidth(self.frame);
        }
        
        frame.origin.y = 0;
        
    }else if (CGRectGetMaxY(self.frame) >= [UIScreen mainScreen].bounds.size.height){
     
        if (CGRectGetMinX(self.frame) <= 0) {
            
            //左下角
            frame.origin.x = 0;
            
        }else if(CGRectGetMaxX(self.frame) >= [UIScreen mainScreen].bounds.size.width){
        
            //右下角
            frame.origin.x = [UIScreen mainScreen].bounds.size.width-CGRectGetWidth(self.frame);
        }
        
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame);
        
    }else if (CGRectGetMinX(self.frame) <= 0){
        
        frame.origin.x = 0;
        
    }else if (CGRectGetMaxX(self.frame) >= [UIScreen mainScreen].bounds.size.width){
        
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.frame);
    }
    
    //四个角落
    if (CGRectGetMinX(self.frame) == 0 && CGRectGetMinY(self.frame) == 0) {
        
        frame.origin.x = 0;
        frame.origin.y = 0;
        
    }else if (CGRectGetMaxX(self.frame) == [UIScreen mainScreen].bounds.size.width && CGRectGetMaxY(self.frame) == [UIScreen mainScreen].bounds.size.height){
        
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.frame);
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.frame);
        
    }else if (CGRectGetMinX(self.frame) == 0 && CGRectGetMaxY(self.frame) == [UIScreen mainScreen].bounds.size.height){
        
        frame.origin.x = 0;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame);
        
    }else if (CGRectGetMaxX(self.frame) == [UIScreen mainScreen].bounds.size.width && CGRectGetMinY(self.frame) == 0){
        
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.frame);
        frame.origin.y = 0;
    }
    
    self.frame = frame;

    //给新的形变
//    self.transform = CGAffineTransformTranslate(<#CGAffineTransform t#>,
//    <#CGFloat tx#>, <#CGFloat ty#>)
    //在原来的基础上形变
//    self.transform = CGAffineTransformMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>)
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"end");
}

//// 触摸结束前，某个系统事件(例如电话呼入)会打断触摸过程，系统会自动调用view的下面方法
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"cancelled");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#endif
@end
