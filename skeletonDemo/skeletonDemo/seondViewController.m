//
//  seondViewController.m
//  skeletonDemo
//
//  Created by macOfEthan on 2018/1/23.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

#import "seondViewController.h"
#import <SkeletonView/SkeletonView-Swift.h>
#import "skeletonDemo-Swift.h"

@interface seondViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation seondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    say *s = [[say alloc] init];
    
//    NSLog(@"%@", [s sayhaha]);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusedId = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    
    UILabel *ll = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    ll.font = [UIFont systemFontOfSize:15];
    ll.textColor = [UIColor redColor];
    ll.text = @"hahahahaha";
    [cell.contentView addSubview:ll];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 30, 30)];
    img.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:img];
    
    ll.isSkeletonable = YES;
    img.isSkeletonable = YES;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
