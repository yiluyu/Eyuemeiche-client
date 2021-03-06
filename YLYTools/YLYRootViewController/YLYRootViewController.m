//
//  YLYRootViewController.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYRootViewController.h"
#import "YLYDefine.h"
#import "YLYDownLoadManager.h"

@interface YLYRootViewController ()

@end

@implementation YLYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_VC_BG;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //判断是否到根控制器, 右滑避免右滑失效
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        //自定义navi加入右滑效果
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setBackBtn];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self closeAllRequest];
}

- (void)setBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_导航栏返回"]
                       forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(backVC)
      forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = YLY6Rect(0, 0, 13, 22);
    backBtn.backgroundColor = COLOR_BLUE;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

- (void)backVC {
    [self.navigationController popViewControllerAnimated:YES];
}

//关闭所有请求
- (void)closeAllRequest {
    YLYDownLoadManager *manager = [YLYDownLoadManager shareManager];
    [manager clearNetBoxInSender:self];
}

@end
