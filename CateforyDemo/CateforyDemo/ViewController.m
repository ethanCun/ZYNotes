//
//  ViewController.m
//  CateforyDemo
//
//  Created by macOfEthan on 17/12/22.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
#import "People+Say.h"
#import "People+say2.h"
#import "Son.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     结构：
     
     typedef struct category_t {
     const char *name;  //类的名字
     classref_t cls;  //类
     struct method_list_t *instanceMethods;  //category中所有给类添加的实例方法的列表
     struct method_list_t *classMethods;  //category中所有添加的类方法的列表
     struct protocol_list_t *protocols;  //category实现的所有协议的列表
     struct property_list_t *instanceProperties;  //category中添加的所有属性
     } category_t;

     
     作用：
     1.可以在不修改原来类的基础上，为一个类扩展方法；
     2.可以减少单个文件的体积;
     3.可以把不同的功能组织到不同的category里;
     4.可以由多个开发者共同完成一个类等等；
     5.可以按需加载想要的category；
     6.声明私有方法；
     7.模拟多继承（另外可以模拟多继承的还有protocol)；
     8.把framework的私有方法公开；

     特点：
     1.调用顺序：分类(category) > 本类 > 父类
     1)、category的方法没有“完全替换掉”原来类已经有的方法，也就是说如果category和原来类都有methodA，那么category附加完成之后，类的方法列表里会有两个methodA。
     
     2)、category的方法被放到了新方法列表的前面，而原来类的方法被放到了新方法列表的后面，这也就是我们平常所说的category的方法会“覆盖”掉原来类的同名方法，这是因为运行时在查找方法的时候是顺着方法列表的顺序查找的，它只要一找到对应名字的方法，就会罢休，殊不知后面可能还有一样名字的方法
     2.如果有两个分类，他们都实现了相同的方法，如何判断谁先执行？分类执行顺序可以通过targets,Build Phases,Complie Source进行调节，及执行最后一个参与编译的category文件，注意执行顺序是从上到下的。（只有两个相同方法名的分类）
     3.分类中可以访问原来类中的成员变量 @public @protected @private(是的@private也可以， 子类在编译期的时候就会报错)
     4.在不使用运行时的情况下：category只能给某个已有的类扩充方法，不能扩充成员变量。
        Category不能添加成员变量（instance variables）编译期即报错 （因为在运行期，对象的内存布局已经确定，如果添加实例变量就会破坏类的内部布局，这对编译型语言来说是灾难性的)
        category中也可以添加属性，只不过@property只会生成setter和getter的声明，不会生成setter和getter的实现以及成员变量。
     5.category是在运行时加载的，不是在编译时
     6.Category的可为（可以添加实例方法，类方法，甚至可以实现协议，添加属性）和不可为（无法添加实例变量）。
     */
    
    People *pp = [People new];
    
    [pp performSelector:@selector(say) withObject:nil afterDelay:0];
    
    //-[People setHeight:]: unrecognized selector sent to
    pp.name = @"zhangsan";
    NSLog(@"pp name = %@", pp.name);
 
    [Son new];
    
    /**
     
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
