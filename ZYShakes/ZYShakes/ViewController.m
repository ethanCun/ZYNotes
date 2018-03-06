//
//  ViewController.m
//  ZYShakes
//
//  Created by macOfEthan on 2018/3/6.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>

//引入震动框架
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_tableView.mj_header endRefreshingWithCompletionBlock:^{
                
                [self rings];
                 
            }];
        });
        
    }];
}

- (SystemSoundID)soundId
{
    SystemSoundID soundID;
    
    NSString *ringsPath = [[NSBundle mainBundle] pathForResource:@"36795fa632f27736d4f35869aa32fbb2.mp3" ofType:nil];
    NSURL *ringsUrl = [NSURL fileURLWithPath:ringsPath];
    
    #pragma mark - 创建自定义铃声soundID
    AudioServicesCreateSystemSoundID(((__bridge CFURLRef _Nonnull)(ringsUrl)), &soundID);
    
    return soundID;
}

#pragma mark - 播放铃声
- (void)rings
{
    /**
     系统铃声列表：https://www.jianshu.com/p/1142f461996b
     */
    //AudioServicesPlayAlertSound(1005);
    
    /**
     自定义声音
     
     *参数说明:
     
     * 1、刚刚播放完成自定义系统声音的ID
     
     * 2、回调函数（playFinished）执行的run Loop，NULL表示main run loop
     
     * 3、回调函数执行所在run loop的模式，NULL表示默认的run loop mode
     
     * 4、需要回调的函数 地址
     
     * 5、传入的参数， 此参数会被传入回调函数里
     

     */
    AudioServicesAddSystemSoundCompletion([self soundId], NULL, NULL, &soundCompleteCallback, (__bridge void*)self);
    
    AudioServicesPlaySystemSound([self soundId]);
}

#pragma mark - 播放回调
void soundCompleteCallback(SystemSoundID sound, void *clientData){
    
    unsigned int ringsId = sound;
    
    NSLog(@"ringsId = %u", ringsId);

    /**
     1. 必须等到播放完成才能清理该ID对应的所有资源(回调函数)
     2. 如果在AudioServicesPlaySystemSound(ID)之后马上调用AudioServicesDisposeSystemSoundID(ID)，你将听不到任何声音,并且也不会调用播放完成后的函数， 这是因为，系统音频播放的所有操作都是放到主线程之外执行的，当主线程执行到清理的时候，该音频如果试图播放ID对应的音频，将无法找到。
     */
    
    //移除完成后执行的函数
    AudioServicesRemoveSystemSoundCompletion(ringsId);
    
    //根据ID释放自定义系统声音
    AudioServicesDisposeSystemSoundID(ringsId);
}


#pragma mark - 震动
- (void)shake
{
    
    /**
     1. kSystemSoundID_Vibrate 震动 效果类似iphone指纹解锁失败的震感 不是短震动
     2. 1519 普通短震，3D Touch 中 Peek 震动反馈
     3. 1520 普通短震，3D Touch 中 Pop 震动反馈
     4. 1521 连续三次短震
     */
    AudioServicesPlayAlertSound(1521);
    
    /**
     短震方法二 获取 _tapticEngine
     
     http://ios.jobbole.com/92573/
     在 iPhone 7 上调用没有震动反馈，在 iPhone 6S Plus 上调用有震动反馈，在 iPhone 6 上调用 无反馈
     */
    //id tapticEngine = [[UIDevice currentDevice] performSelector:NSSelectorFromString(@"_tapticEngine") withObject:nil];
    //[tapticEngine performSelector:NSSelectorFromString(@"actuateFeedback") withObject:@(0)];
    
    /**下面三种适用设备iPhone 7和iPhone 7 Plus上 参考链接：
     https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS10.html#//apple_ref/doc/uid/TP40017084-SW7
     */
    /**
     UIImpactFeedbackGenerator  如下拉刷新完成
     
     UIImpactFeedbackStyleLight,轻度点击
     UIImpactFeedbackStyleMedium, 中度点击
     UIImpactFeedbackStyleHeavy  重度点击
     */
    //UIImpactFeedbackGenerator  *feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    //[feedbackGenerator prepare];
    //[feedbackGenerator impactOccurred];
    
    /**
     UINotificationFeedbackGenerator 例如任务完成时
     
     UINotificationFeedbackTypeSuccess,
     UINotificationFeedbackTypeWarning,
     UINotificationFeedbackTypeError
     */
    //UINotificationFeedbackGenerator *notificationFeedbackgenerator = [[UINotificationFeedbackGenerator alloc] init];
    //[notificationFeedbackgenerator notificationOccurred:UINotificationFeedbackTypeWarning];
    
    /**UISelectionFeedbackGenerator 选择切换 例如用户在滚动选取轮时的感觉*/
    //UISelectionFeedbackGenerator *selectionFeedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    //[selectionFeedbackGenerator selectionChanged];
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
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self rings];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


@end
