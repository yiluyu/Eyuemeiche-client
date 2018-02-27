//
//  MainView.m
//  Eyuemeiche
//
//  Created by yu on 26/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MainView.h"

#import "MainConfig.h"

@interface MainView ()

@property (nonatomic, readwrite, strong)YLYRootView *backView;
//地图
@property (nonatomic, readwrite, strong)MAMapView *mapView;

//头部
@property (nonatomic, readwrite, strong)YLYRootView *headerView;
@property (nonatomic, readwrite, strong)UIButton *myButton;//我的
@property (nonatomic, readwrite, strong)UIButton *cityButton;//修改城市
@property (nonatomic, readwrite, strong)UIButton *messageButton;//信息

//底部
@property (nonatomic, readwrite, strong)UIButton *returnMyLocationBtn;//回到当前定位位置
@property (nonatomic, readwrite, strong)SwitchButton *orderSwitchButton;//订单类型选择
@property (nonatomic, readwrite, strong)YLYRootView *localView;//定位信息视图
@property (nonatomic, readwrite, strong)YLYRootLabel *localLabel;//显示
@property (nonatomic, readwrite, strong)YLYRootButton *bookOrderBtn;//下订单


//底部
@property (nonatomic, readwrite, strong)YLYRootView *switchView;


@end

@implementation MainView

- (void)layoutSubviews {
    self.backView = [[YLYRootView alloc] init];
    _backView.backgroundColor = COLOR_CLEAR;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    //最下层map
    [self creatMapView];
    
    //上半部分
    [self creatHeaderView];
    
    //下半部分
    [self creatBottomView];

}


- (void)creatMapView {
//    self.mapView = [[MAMapView alloc] init];
//    _mainMap.backgroundColor = COLOR_CLEAR;
//    [self addSubview:_mainMap];
//    [_mainMap mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
}


- (void)creatHeaderView {
    self.headerView = [[YLYRootView alloc] init];
    _headerView.backgroundColor = COLOR_CLEAR;
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(YLY6Width(750), YLY6Width(100)));
        make.top.mas_equalTo(YLY6Width(20));
    }];
    
    //我的
    
    
    
    //显示城市
    
    
    //信息
    
    
}


- (void)creatBottomView {
    //回到当前定位点
    
    
    
    //选择器
    self.switchView = [[YLYRootView alloc] init];
    _switchView.backgroundColor = COLOR_CLEAR;
    [self addSubview:_switchView];
    [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    //地址
    
    
    
    //预定
}





@end
