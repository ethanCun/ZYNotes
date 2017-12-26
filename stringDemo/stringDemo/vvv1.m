//
//  vvv1.m
//  stringDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "vvv1.h"
#import "vvv2.h"
#import "vvv3.h"

@implementation vvv1

//只要事件一传递给一个控件,这个控件就会调用他自己的hitTest：withEvent：方法
//注 意：不管这个控件能不能处理事件，也不管触摸点在不在这个控件上，事件都会先传递给这个控件，随后再调用hitTest:withEvent:方法
//目的：寻找并返回最合适的view(能够响应事件的那个最合适的view)

/**
 正因为hitTest：withEvent：方法可以返回最合适的view，所以可以通过重写hitTest：withEvent：方法，返回指定的view作为最合适的view。
 不管点击哪里，最合适的view都是hitTest：withEvent：方法中返回的那个view。
 通过重写hitTest：withEvent：，就可以拦截事件的传递过程，想让谁处理事件谁就处理事件。
 
 */

/**
 
 技巧：想让谁成为最合适的view就重写谁自己的父控件的hitTest:withEvent:方法返回指定的子控件，或者重写自己的hitTest:withEvent:方法 return self。但是，建议在父控件的hitTest:withEvent:中返回子控件作为最合适的view！
 
 原因在于在自己的hitTest:withEvent:方法中返回自己有时候会出现问题。因为会存在这么一种情况：当遍历子控件时，如果触摸点不在子控件A自己身上而是在子控件B身上，还要要求返回子控件A作为最合适的view，采用返回自己的方法可能会导致还没有来得及遍历A自己，就有可能已经遍历了点真正所在的view，也就是B。这就导致了返回的不是自己而是触摸点真正所在的view。所以还是建议在父控件的hitTest:withEvent:中返回子控件作为最合适的view！
 
 */

/**
 特殊情况：
 谁都不能处理事件，窗口也不能处理。
 
 重写window的hitTest：withEvent：方法return nil
 只能有窗口处理事件。
 
 控制器的view的hitTest：withEvent：方法return nil或者window的hitTest：withEvent：方法return self
 return nil的含义：
 hitTest：withEvent：中return nil的意思是调用当前hitTest：withEvent：方法的view不是合适的view，子控件也不是合适的view。如果同级的兄弟控件也没有合适的view，那么最合适的view就是父控件。
 */

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"v1 hitText");
    
    /**
     点击子视图超出父视图范围的区域任然 响应子视图
     */
    if ([self.layer containsPoint:point] == NO) {
        
        
        for (UIView *subView in self.subviews) {
            
            
            if ([subView.layer containsPoint:point] == YES) {
                
                return subView;
            }
        }
        
        return nil;
    }
    
    /**
     注 意：如果hitTest:withEvent:方法中返回nil，那么调用该方法的控件本身和其子控件都不是最合适的view，也就是在自己身上没有找到更合适的view。那么最合适的view就是该控件的父控件。
     */
//    return nil;
    
    //拦截所有的事件交给vvv2
//    return self.subviews.lastObject;
    
    //点击vvv1和vvv2没反应 点击vvv3响应事件
//    UIView *v = [super hitTest:point withEvent:event];
//    if ([v isKindOfClass:[vvv1 class]] || [v isKindOfClass:[vvv2 class]]) {
//        return nil;
//    }
//    
    
    return [super hitTest:point withEvent:event];
}

/**
 pointInside:withEvent:方法判断点在不在当前view上（方法调用者的坐标系上）如果返回YES，代表点在方法调用者的坐标系上;返回NO代表点不在方法调用者的坐标系上，那么方法调用者也就不能处理事件。
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"v1 pointInside");
    
    //拦截自己和子视图的事件
//    return NO;
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
