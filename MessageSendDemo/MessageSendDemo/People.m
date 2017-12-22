//
//  People.m
//  MessageSendDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "People.h"
#import <objc/message.h>

@implementation People

#if 0
#pragma mark - 1.动态方法解析
/**
 对象在收到无法处理的消息时，会调用下面的方法，前者是调用类方法时会调用，后者是调用对象方法时会调用
 */
+ (BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"sel class = %@", NSStringFromSelector(sel));
    
    return YES;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    /**
     在该方法中，需要给对象所属类动态的添加一个方法，并返回YES，表明可以处理
     */
    NSLog(@"sel instance = %@", NSStringFromSelector(sel));
    
     /**
     添加方法
     
     @param self 调用该方法的对象
     @param sel 方法名称
     @param IMP 新添加的方法，是c语言实现的 表示由编译器生成的、指向实现方法的指针。也就是说，这个指针指向的方法就是我们要添加的方法。
     @param 新添加的方法的类型，包含函数的返回值以及参数内容类型，eg：void xxx(NSString *name, int size)，类型为：v@i
      比如：”v@:”意思就是这已是一个void类型的方法，没有参数传入。
      再比如 “i@:”就是说这是一个int类型的方法，没有参数传入。
      再再比如”i@:@”就是说这是一个int类型的方法，又一个参数传入。
     */
    if ([NSStringFromSelector(sel) isEqualToString:@"say"]) {
        
        class_addMethod(self, sel, class_getMethodImplementation(self, @selector(haha:)), "v@:@");
        
//        class_addMethod(self, sel, (IMP)sayHaha, "v@:@");
        
        return YES;
    }
    
    return NO;
}

void sayHaha(NSString * ss){

    NSLog(@"%@ c语言方式", ss);
}

- (void)haha:(NSString *)s
{
    NSLog(@"ss = %@ hahaha", s);
}
#endif

#if 0
#pragma mark - 2.备援接受者
/**
 经历了第一步后，如果该消息还是无法处理，那么就会调用下面的方法，查询是否有其它对象能够处理该消息 
 在这个方法里，我们需要返回一个能够处理该消息的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(say)) {
        
        return [People new];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}
#endif

#pragma mark - 3.完整的消息转发
/**
 经历了前两步，还是无法处理消息，那么就会做最后的尝试，先调用methodSignatureForSelector:获取方法签名，然后再调用forwardInvocation:进行处理，这一步的处理可以直接转发给其它对象，即和第二步的效果等效，但是很少有人这么干，因为消息处理越靠后，就表示处理消息的成本越大，性能的开销就越大。所以，在这种方式下，会改变消息内容，比如增加参数，改变选择子等等。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"say"]) {
        
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return methodSignature;
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSMethodSignature *methodSignture = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    anInvocation = [NSInvocation invocationWithMethodSignature:methodSignture];
    anInvocation.target = self;
    anInvocation.selector = @selector(sayGoodBye:);
    NSString *city = @"长沙";
    [anInvocation setArgument:&city atIndex:2];
    
    if ([self respondsToSelector:@selector(sayGoodBye:)]) {
        
        [anInvocation invokeWithTarget:self];
        
        return;
        
    }else{
        
        People *pp = [People new];
        
        if ([pp respondsToSelector:@selector(sayGoodBye:)]) {
            
            [anInvocation invokeWithTarget:pp];
            
            return;
        }
    }
    
    return [super forwardInvocation:anInvocation];
}

- (void)sayGoodBye:(NSString *)s
{
    NSLog(@"byebye %@", s);
}

@end
