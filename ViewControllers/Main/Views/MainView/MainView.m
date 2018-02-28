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
    _headerView.backgroundColor = COLOR_GREEN;
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(YLY6Width(750), YLY6Width(100)));
        make.top.mas_equalTo(STATUEBAR_HEIGHT);
    }];
    
    
    //我的
    self.myButton = [[YLYRootButton alloc] init];
    _myButton.backgroundColor = COLOR_BLUE;
    [_headerView addSubview:_myButton];
    [_myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(38));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(36), YLY6Width(36)));
        make.top.mas_equalTo(YLY6Width(32));
    }];
    
    
    //显示城市
    self.cityButton = [[YLYRootButton alloc] init];
    _cityButton.backgroundColor = COLOR_RED;
    [_headerView addSubview:_cityButton];
    [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(260));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(230), YLY6Width(100)));
        make.top.mas_equalTo(YLY6Width(0));
    }];
    _cityButton.titleLabel.font = CONSTANT_FONT_BIG;
    
    //信息
    self.messageButton = [[YLYRootButton alloc] init];
    _messageButton.backgroundColor = COLOR_GRAY;
    [_headerView addSubview:_messageButton];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(676));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(38), YLY6Width(28)));
        make.top.mas_equalTo(YLY6Width(33));
    }];
    
}


- (void)creatBottomView {
    //回到当前定位点
    
    
    
    //选择器
    self.orderSwitchButton = [[SwitchButton alloc] init];
    _orderSwitchButton.backgroundColor = COLOR_CLEAR;
    [self addSubview:_orderSwitchButton];
    [_orderSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    //地址
    
    
    
    //预定
}





@end
