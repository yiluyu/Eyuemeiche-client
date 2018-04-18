//
//  YLYRootViewController.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYRootViewController.h"

@interface YLYRootViewController ()

@end

@implementation YLYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


@end
