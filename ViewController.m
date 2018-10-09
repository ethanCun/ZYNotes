//
//  ViewController.m
//  内存对齐
//
//  Created by chenzhengying on 2018/9/21.
//  Copyright © 2018年 canzoho. All rights reserved.
//

/**
 参考：https://blog.csdn.net/xiong452980729/article/details/70140050
 
 */

#import "ViewController.h"

/*
 分析：    0 1 2 3 4 5 6 7 8 9 10 11 12
 假设地址： a       b       c        |
 
 1. 结构体的有效对齐值的确定：当未明确指定时，以结构体中最长的成员的长度为其有效值
 2. b是Int类型 对应的内存地址必须为0 4 8倍数
 */
typedef struct {
    
    char a;
    int b;
    char c;
} AA1;

/*
 分析：    0 1 2 3 4 5 6 7 8 9 10 11 12
 假设地址： b       a c       |
 
 1. 结构体的有效对齐值的确定：当未明确指定时，以结构体中最长的成员的长度为其有效值
 2. 结构体的总大小为结构体的有效对齐值的整数倍 这里大小为8个字节
 */
typedef struct {
    int b;
    char a;
    char c;
} AA2;

/*
 分析：    0 1 2 3 4 5 6 7 8 9 10 11 12
 假设地址： a c     b       |
 
 结构体的总大小为结构体的有效对齐值的整数倍 这里大小为8个字节
 */
typedef struct {
    
    char a;
    char c;
    int b;
} AA3;

/*
 分析：    0 1 2 3 4 5 6 7 8 9 10 11 12
 假设地址： a       b       c    |
 
 
 #pragma pack(2)：
 结构体的总大小为结构体的有效对齐值的整数倍 结构体的有效对齐长度在pack指定的2和int的4中取较小的值2 应该是10字节 但是这里输出为8？
 #pragma pack(8)：
  结构体的总大小为结构体的有效对齐值的整数倍 结构体的有效对齐长度在pack指定的8和int的4中取较小的值4 还是12字节
 */
#pragma pack(2)
typedef struct {
    
    char a;
    int b;
    char c;
    
} AA4;

/*
 分析：    0 1 2 3 4 5 6 7 8 9 10 11 12
 假设地址： a       b       c |
 
 无效？
 */
typedef struct {
    char a;
    int b;
    char c;
}__attribute__((__1__)) AA5;

@interface ViewController ()

@property (nonatomic, assign) AA1 aa1;
@property (nonatomic, assign) AA2 aa2;
@property (nonatomic, assign) AA3 aa3;
@property (nonatomic, assign) AA4 aa4;
@property (nonatomic, assign) AA5 aa5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     C中内存对齐原则
     
     原则：
     1.结构体内成员按自身长度自对齐。
     自身长度，如char=1，short=2，int=4，double=8,。所谓自对齐，指的是该成员的起始位置的内存地址必须是它自身长度的整数倍。如int只能以0,4,8这类的地址开始
     2.结构体的总大小为结构体的有效对齐值的整数倍
     
     ---------------------
     
     结构体的有效对齐值的确定：
     1）当未明确指定时，以结构体中最长的成员的长度为其有效值
     2）当用#pragma pack(n)指定时，以n和结构体中最长的成员的长度中较小者为其值。
     3）当用__attribute__ ((__packed__))指定长度时，强制按照此值为结构体的有效对齐值
     
     ---------------------
     */
    
    NSLog(@"aa1: %ld", sizeof(self.aa1));
    NSLog(@"aa2: %ld", sizeof(self.aa2));
    NSLog(@"aa3: %ld", sizeof(self.aa3));
    NSLog(@"aa4: %ld", sizeof(self.aa4));
    NSLog(@"aa5: %ld", sizeof(self.aa5));
    
    /**
     总结内存优化技巧： 内存占用大的变量声明在前 如Double>Int>Short>Char Swift中Optional类型多占1个字节 因此
     */
}





@end
