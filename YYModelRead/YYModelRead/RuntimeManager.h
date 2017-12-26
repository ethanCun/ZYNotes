//
//  RuntimeManager.h
//  YYModelRead
//
//  Created by macOfEthan on 17/12/26.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol changeTheme <NSObject>

/**在协议、分类中声明的属性，只有对应的setter／getter方法，并没有生成对应的成员变量。*/
/**通过使用@synthesize指定该属性的成员变量*/
@property float speed;
@property (nonatomic, strong) UIColor *currentColor;

- (void)changeTheme;

@end

@interface RuntimeManager : NSObject
{
    NSString *_name;
    NSString *_age;
    NSString *_sex;
    
    NSInteger _height;
    NSInteger _weight;
    int _text;
    
    NSArray *_interest;
    NSDictionary *_params;
    
    NSNumber *_address;
}

/**在OC中的给类添加成员属性其实就是添加了一个成员变量和getter以及setter方法。*/
@property (nonatomic, copy) NSString *location;

@property (nonatomic, assign) BOOL isOld;

+ (instancetype)share;
+ (void)sayH;
- (void)say:(NSString *)s1 s:(NSString *)s2;
- (void)hello;
- (void)bye;

@property(nonatomic, weak) id<changeTheme>delegate;

/**1、获取类名*/
- (NSString *)getClassNameWithClass:(Class)cls;

/**增加实例变量*/
- (BOOL)addIvarWithClass:(Class)cls;

/**2、获取成员变量*/
- (NSArray *)getIvarListWithClass:(Class)cls;

/**获取成员属性*/
- (NSArray *)getPropertyListWithClass:(Class)cls;

/**获取类的实例方法*/
- (NSArray *)getInstanceMethodWithClass:(Class)cls;

/**获取协议列表*/
- (NSArray *)getProtocalListWithClass:(Class)cls;

/**方法实现交换*/
- (void)methodImplemetationExchangeWithClass:(Class)class sel1:(SEL)sel1 sel2:(SEL)sel2;
@end
