//
//  MainViewController.m
//  EDongMeiCheDemo
//
//  Created by yu on 30/10/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "MainViewController.h"
#import "MainConfig.h"
#import "MyInfoVC.h"
#import "MakeOrderVC.h"
#import "BootUnit.h"
#import "YLYBaseViewHeader.h"

@interface MainViewController ()

@property (nonatomic, readwrite, strong)MainView *mainView;//主页面

@property (nonatomic, readwrite, strong)MainSlideView *slideView;//侧滑栏

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听登陆状态
    [self addLoginNotificationObserver];
    
    //设置nav
    [self setNavigationBarStyle];
    
    //主页subviews
    [self createSubViews];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //模拟登陆失败
    [self loginFaild];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavigationBarStyle];
    //请求
    [self requestWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    BootUnit *bu = [BootUnit shareUnit];
    [bu pushLoginVC];
}

//登陆失败
- (void)loginFaild {
    //3秒后发起登陆失败
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:CONSTANT_NOTIFY_SKIPLOGIN object:nil];
    });
}

//设置导航
- (void)setNavigationBarStyle {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}


/* 页面 */
//主页面初始化
- (void)createSubViews {
    self.mainView = [[MainView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _mainView.backgroundColor = COLOR_WHITE;

    SELF_WEAK();
    //点击侧边栏
    _mainView.myBtnBlock = ^{
        [weakSelf openLeftSideView];
    };
    //点击消息盒子
    _mainView.messageBtnBlock = ^{
        [weakSelf enterMessageVC];
    };
    //点击我要洗车
    _mainView.callBtnBlock = ^(NSDictionary *dict) {
        [weakSelf enterMakeOrderVC:dict];
    };
    
    //每次从地图坐标搜索服务器时间
    _mainView.mapSearchBlock = ^(CLLocationCoordinate2D location) {
        ;
    };
}

//进入个人详情
- (void)enterMyInfoVC {
    [_slideView hide];
    
    MyInfoVC *infoVC = [[MyInfoVC alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}




#pragma -mark request
//即将进入主页请求
- (void)requestWillAppear {
    //message盒子请求
    [self requestMessage];
}

//信息请求
- (void)requestMessage {
    YLYLog(@"-----私信数量请求待定");
}

#pragma -mark method
//打开左侧栏
- (void)openLeftSideView {
    if (self.slideView == nil) {
        self.slideView = [[MainSlideView alloc] init];
        
        SELF_WEAK();
        //cell点击
        _slideView.slideViewCellClick = ^(NSIndexPath *indexPath) {
            YLYLog(@"----- 侧边栏点击cell 未完成 %@", indexPath);
        };
        
        //header点击
        _slideView.slideViewHeaderClick = ^{
            [weakSelf enterMyInfoVC];
        };
    }
    [_slideView show];
}

#pragma -mark 推送页面
//进入消息盒子
- (void)enterMessageVC {
    MessageVC *nextVC = [[MessageVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

//进入制作订单
- (void)enterMakeOrderVC:(NSDictionary *)dict {
    MakeOrderVC *nextVC = [[MakeOrderVC alloc] init];
    MAKEORDER_TYPE type = kNormalType;
    
    if ([dict[@"orderType"] floatValue] == 100) {
        //当前
        type = kNormalType;
    } else {
        //预约
        type = kReserveType;
    }
    nextVC.type = type;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
