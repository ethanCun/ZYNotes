//
//  ViewController.m
//  YYModelRead
//
//  Created by macOfEthan on 17/12/24.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "people.h"
#import "son.h"
#import "Text.h"
#import <objc/message.h>
#import "RuntimeManager.h"
#import "NSString+Say.h"
#import "UIImage+name.h"

@interface ViewController ()<changeTheme>
{
    NSString *_name;
}
@property (nonatomic, strong) Text *text;

@property (nonatomic, assign) NSInteger length;


@end

@implementation ViewController

/**
 @synthesize 上面声明部分的 @synthesize speed = _speed; 意思是说，speed 属性为 _speed 成员变量合成访问器方法。 也就是说，speed属性生成存取方法是setSpeed，这个setSpeed方法就是_speed变量的存取方法，它操作的就是_speed这个变量。通过这个看似是赋值的这样一个操作，我们可以在@synthesize 中定义与变量名不相同的getter和setter的命名，籍此来保护变量不会被不恰当的访问。
 Category中的implementation中不支持用@synthesize 来合成属性.正确的做法使用关联属性.
 
 补充：@dynamic 和 @synthesize的区别：
 在@implementation 中通过@dynamic xxx 告诉编译器、xxx属性的setter、getter方法由开发者自己来生成
 @ synthesize xxx = _xxx； 告诉编译器、xxx属性的setter、getter方法由编译器来生成、同时用_xxx 来合成 成员变量
 */
@synthesize speed = _zySpeed;
@synthesize currentColor = _zyCurrentColor;

@dynamic length;


#pragma mark - 利用消息转发机制来实现@dynamic的setter和getter方法
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSString *sel = NSStringFromSelector(selector);
    
    if ([sel rangeOfString:@"set"].location == 0)
    {
        //setter
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    
    else
    {
        //getter
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSMutableDictionary *propertiesDict = [[NSMutableDictionary alloc] init];
    
    NSString *key = NSStringFromSelector([invocation selector]);
    
    if ([key rangeOfString:@"set"].location == 0)
    {
        key= [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        
        NSInteger obj;
        
        [invocation getArgument:&obj atIndex:2];
        
        [propertiesDict setObject:@(obj) forKey:key];
        
    }
    else
    {
        NSString *obj = [propertiesDict objectForKey:key];
        
        [invocation setReturnValue:&obj];
    }
    
}


- (void)changeTheme
{
    NSLog(@"changeTheme");
    
    self.view.backgroundColor = _zyCurrentColor;
    
    self.length = 100;
    
    NSLog(@"llllength = %ld", self.length);
}


- (void)runtime
{
    NSLog(@"===========runtime===========");
    
    RuntimeManager *manager = [RuntimeManager new];
    
    manager.delegate = self;
    
    self.speed = 100;
    
    self.currentColor = [UIColor redColor];
    
    NSLog(@"speed = %f", _zySpeed);
    
    /**
     objc_msgSend()报错Too many arguments to function call ,expected 0,have3:
     Build Setting--> Apple LLVM 6.0 - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO
     */
    objc_msgSend(manager, @selector(say:s:), @"123", @"456");
    
    /**关联setter与getter*/
    manager.location = @"changsha";
    NSLog(@"location = %@", manager.location);
    
    Class cls = [manager class];
    
    /**
     导入 #import <objc/message.h>
     在所有Runtime 以char *定义的API都被视为UTF-8编码
     */
//    objc_msgSend(manager, sel_registerName("sayHaha"));
    
    NSLog(@"%@", [manager getClassNameWithClass:cls]);
    
    
    /**
     关于实例变量的编码类型
     基本类型都是由一个字母代替的，
     q -> NSInteger; i -> int B -> bool
     引用类型的话，则直接就是一个字符串了
     @\"NSString\" -> NSString  @\"NSNumber\" -> NSNumber
     @\"NSDictionary\" -> NSDictionary @\"NSArray\" -> NSArray
     
     
     关于ivar_getOffset指针偏移量 为8位 1个字节
     */
    
    /**输出实例变量列表*/
    NSLog(@"输出实例变量列表");
    for (NSDictionary *dic in [manager getIvarListWithClass:cls]) {
        
        NSLog(@"dic = %@", dic);
    }
    
    
    /**输出属性列表*/
    NSLog(@"输出属性列表");
    for (NSDictionary *dic in [manager getPropertyListWithClass:cls]) {
        
        NSLog(@"dic = %@", dic);
    }
    
    /**输出方法列表*/
    NSLog(@"输出方法列表");
    for (NSDictionary *dic in [manager getInstanceMethodWithClass:cls]) {
        
        NSLog(@"dic = %@", dic);
    }
    
    /**输出协议列表*/
    NSLog(@"输出协议列表");
    for (NSDictionary *dic in [manager getProtocalListWithClass:cls]) {
        
        NSLog(@"dic = %@", dic);
    }
    
    /**交换方法实现*/
    NSLog(@"交换方法实现");
    [manager methodImplemetationExchangeWithClass:cls sel1:@selector(hello) sel2:@selector(bye)];
    
    [manager hello];
    [manager bye];
    
    NSString *s = [NSString stringWithString:@"111"];
    
    NSLog(@"交换方法实现 s = %@", [s stringByAppendingString:@"122121& "]);
    
    UIImage *image = [UIImage imageNamed:@"1"];
    
    NSLog(@"===========runtime===========");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self runtime];
//    NSLog(@"haha = %@", haha);
    
    NSProxy *ttt = nil;
    
    
    NSLog(@"%@", externText);
    
    self->_name = @"ethan";
    
    NSLog(@"_name = %@", self->_name);
    
    [people new];
    [son new];
    
    
 //    [self sstatic];

    
//    [self unsafeunretainedAndWeak];
    
//    [self __weakAnd__strong];
}

- (void)__weakAnd__strong
{
    Text *text = [Text new];
    
    
    __weak typeof(Text *) weakText = text;
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"pre weakText = %@", weakText);
        
        //        __strong typeof(Text *) strongText = weakText;
        
        NSInteger i = 0;
        
        while (i < 10) {
            
            NSLog(@"weakText = %@  ", weakText);
            //            NSLog(@"strongText = %@", strongText);
            i++;
            
            sleep(2);
        }
        
    });
    

}

- (void)unsafeunretainedAndWeak
{
    
    id __weak obj2 = [[NSMutableArray alloc] init];
    
    [obj2 addObject:@"2"];
    
    NSLog(@"__weak obj2 = %@", obj2);
    
    id __unsafe_unretained obj1 = [[NSMutableArray alloc] init];
    
    //    [obj1 addObject:@"1"];
    
    id __unsafe_unretained obj3 = nil;
    {
        id __strong obj0 = [[NSMutableArray alloc] init];
        
        [obj0 addObject:@"obj3"];
        
        obj3 = obj0;
        
        NSLog(@"obj0 = %@", obj0);
        
        NSLog(@"obj3 = %@", obj3);
    }
    
    //    NSLog(@"obj33 = %@", obj3);
    
    id __unsafe_unretained obj4 = nil;
    
    NSLog(@"obj4 = %@", obj4);
}

- (void)sstatic
{
    [self log];
    [self log];
    [self log];
}

- (void)log
{
    static NSInteger a = 10;
    a++;
    
    NSInteger b = 10;
    b++;
    
    NSLog(@"a = %ld b = %ld", a, b);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
