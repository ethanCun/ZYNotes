//
//  RuntimeManager.m
//  YYModelRead
//
//  Created by macOfEthan on 17/12/26.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "RuntimeManager.h"
#import <objc/message.h>



@interface RuntimeManager()

@property (nonatomic, assign) NSInteger nnnn;


@end

@implementation RuntimeManager

static NSString *locationKey = @"location";
@dynamic location;

- (void)setLocation:(NSString *)location
{
    objc_setAssociatedObject(self, &locationKey, location, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)location
{
    return objc_getAssociatedObject(self, &locationKey);
}

#pragma mark - 动态增加实例变量 无效？ 具体参考objc对象的本质 此时内存已经分配完成
- (BOOL)addIvarWithClass:(Class)cls
{
    /**
     运行时规定,只能在objc_allocateClassPair与objc_registerClassPair两个函数之间为类添加变量
     */
    //额外空间  变量size sizeof(NSString)   未知,通常设置为 0
    Class subClass = objc_allocateClassPair(cls, "RuntimrManagerSubClass", 0);
    
    //class,变量名,变量size,对齐,类型
    BOOL flag = class_addIvar(subClass, "expression", sizeof(NSString *), 0, "*");
    
    NSLog(@"%@", flag ? @"succeed" : @"failed");
    
    objc_registerClassPair(subClass);
    
    return flag;
}

#pragma mark - 动态增加属性

NSString *cccc(id self, SEL _cmd){
    
    Ivar ivar = class_getInstanceVariable([RuntimeManager class], "_cccc");
    return object_getIvar(self, ivar);
}

void setCccc(id self, SEL _cmd){
    
    Ivar ivar = class_getInstanceVariable([RuntimeManager class], "_cccc");
    id oldCccc = object_getIvar(self, ivar);
    
    object_setIvar(self, ivar, [oldCccc copy]);
}


- (BOOL)addPropertyWithClass:(Class)cls
{
//    objc_allocateClassPair([RuntimeManager class], "subclass", 0);
    
    objc_property_attribute_t type = {"T", "\"NSString\""};
     // C = copy
    objc_property_attribute_t ownnerShip = {"C", ""};
    objc_property_attribute_t backingIvar = {"V", "_cccc"};
    objc_property_attribute_t attr[] = {type, ownnerShip, backingIvar};
    
    BOOL isSucceed = class_addProperty(cls, "cccc", attr, 2);
    
    //添加setter与getter @@:表示返回为字符串 参数为空 "v@:@"表示返回为空 带一个字符串参数
//    class_addMethod(cls, @selector(cccc), (IMP)cccc, "@@:");
//    class_addMethod(cls, @selector(setCccc:), (IMP)setCccc, "v@:@");
    
    [self addMethodWithClass:cls sel:@selector(cccc) impSelector:@selector(cccc)];
    [self addMethodWithClass:cls sel:@selector(setCccc:) impSelector:@selector(setCccc:)];
    return isSucceed;
}

#pragma mark - 动态增加方法
- (void)addMethodWithClass:(Class)class sel:(SEL)sel impSelector:(SEL)impSelector
{
    Method method = class_getInstanceMethod(class, sel);
    IMP methodImp = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    
    //动态绑定sel与imp
    class_addMethod(class, sel, methodImp, types);
}

#pragma mark - 获取类名
- (NSString *)getClassNameWithClass:(Class)cls
{
    const char *class = object_getClassName(cls);
    
    return [NSString stringWithUTF8String:class];
}

#pragma mark - 获取实例变量列表
- (NSArray *)getIvarListWithClass:(Class)cls
{
    unsigned int count = 0;
    
#pragma mark - 添加实例变量 怎么感觉无效？
    [self addIvarWithClass:cls];
    
    Ivar *ivarList = class_copyIvarList(cls, &count);
    
    NSMutableArray *ivars = [NSMutableArray array];
    for (NSInteger i=0; i<count; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        ptrdiff_t ivarOffset = ivar_getOffset(ivarList[i]);
        
        [dic setObject:[NSString stringWithUTF8String:ivarName] forKey:@"name"];
        [dic setObject:[NSString stringWithUTF8String:ivarType] forKey:@"type"];
        [dic setObject:@(ivarOffset) forKey:@"offset"];
        
        [ivars addObject:dic];
    }
    
    free(ivarList);
    
    return [NSMutableArray arrayWithArray:ivars];
}

#pragma mark - 3.获取成员属性 包括公有私有 以及定义在扩展里的属性
- (NSArray *)getPropertyListWithClass:(Class)cls
{
    [self addPropertyWithClass:cls];
    
    unsigned int count = 0;
    
    objc_property_t *propertys = class_copyPropertyList([RuntimeManager class], &count);
    
    NSMutableArray *props = [NSMutableArray array];
    for (NSInteger i=0; i<count; i++) {
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        const char *name = property_getName(propertys[i]);
        const char *attr = property_getAttributes(propertys[i]);
        
        [paras setObject:[NSString stringWithUTF8String:name] forKey:@"name"];
        [paras setObject:[NSString stringWithUTF8String:attr] forKey:@"attr"];
        
        [props addObject:paras];
    }
    
    free(propertys);
    
    return [NSArray arrayWithArray:props];
}

#pragma mark - 获取类的实例方法
- (NSArray *)getInstanceMethodWithClass:(Class)cls
{
    unsigned int count = 0;
    
#pragma mark - 不能获取类方法 没实现的方法不能获取
    Method *method = class_copyMethodList(cls, &count);
    
    NSMutableArray *methods = [NSMutableArray array];
    
    for (NSInteger i=0; i<count; i++) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        SEL name = method_getName(method[i]);
        const char *type = method_getTypeEncoding(method[i]);
//        IMP imp = method_getImplementation(method[i]);
        unsigned int argueNum = method_getNumberOfArguments(method[i]);
        
        [params setObject:NSStringFromSelector(name) forKey:@"sel"];
//        [params setObject:[NSString stringWithUTF8String:imp] forKey:@"imp"];
        [params setObject:[NSString stringWithUTF8String:type] forKey:@"type"];
        [params setObject:@(argueNum) forKey:@"argueNum"];
        
        [methods addObject:params];
    }
    
    free(method);
    
    return methods;
}

#pragma mark - 获取协议列表
- (NSArray *)getProtocalListWithClass:(Class)cls
{
    unsigned int count = 0;
    
    __unsafe_unretained Protocol ** protocolList = class_copyProtocolList(cls, &count);
    
    NSMutableArray *protocols = [NSMutableArray array];
    
    for (NSInteger i=0; i<count; i++) {
        
        const char *name =  protocol_getName(protocolList[i]);
        
        [protocols addObject:[NSString stringWithUTF8String:name]];
    }
    
    free(protocolList);
    
    return [NSArray arrayWithArray:protocols];
}


+ (void)sayH
{
    NSLog(@"sayH");
}

- (void)say:(NSString *)s1 s:(NSString *)s2
{
    
    if ([self.delegate respondsToSelector:@selector(changeTheme)]) {
        
        [self.delegate changeTheme];
    }
}

#pragma mark - 方法实现交换
- (void)methodImplemetationExchangeWithClass:(Class)class sel1:(SEL)sel1 sel2:(SEL)sel2
{
    Method method1 = class_getInstanceMethod(class, sel1);
    Method method2 = class_getInstanceMethod(class, sel2);
    
    method_exchangeImplementations(method1, method2);
    
}

- (void)hello
{
    NSLog(@"hello");
    
    [self hello];
}

- (void)bye
{
    NSLog(@"bye");
}

#pragma mark - 关联取值


@end
