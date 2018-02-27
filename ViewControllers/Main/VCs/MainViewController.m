//
//  MainViewController.m
//  EDongMeiCheDemo
//
//  Created by yu on 30/10/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "MainViewController.h"
#import "MainConfig.h"


@interface MainViewController ()

@property (nonatomic, readwrite, strong)MainView *mainView;//主页面

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听登陆状态
    [self addLoginNotificationObserver];
    
    //主页subviews
    [self creatMainView];
    
    
    
    
    
    //模拟登陆失败
    [self loginFaild];
}





/* 事件 */

//监听登陆状态
- (void)addLoginNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(skipLoginVC)
                                                 name:CONSTANT_NOTIFY_SKIPLOGIN
                                               object:nil];
}

//跳转登陆页
- (void)skipLoginVC {
    YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    if (propertyManager.loginVCShowing == YES) {
        return;
    } else {
        BootUnit *bu = [BootUnit shareUnit];
        [bu pushLoginVC];
    }
}

//登陆失败
- (void)loginFaild {
    //3秒后发起登陆失败
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:CONSTANT_NOTIFY_SKIPLOGIN object:nil];
    });
}



/* 页面 */
//主页面初始化
- (void)creatMainView {
    self.mainView = [[MainView alloc] init];
    [self.view addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
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
