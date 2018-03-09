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
{
    ORDERTYPE orderType;//当前预约类型
}

@property (nonatomic, readwrite, strong)YLYRootView *backView;
//地图
@property (nonatomic, readwrite, strong)MAMapView *mapView;

//头部
@property (nonatomic, readwrite, strong)YLYRootView *headerBarView;
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
    [self creatHeaderBarView];
    
    //下半部分
    [self creatBottomView];

}


- (void)creatMapView {
//    self.mapView = [[MAMapView alloc] init];
//    _mainMap.backgroundColor = COLOR_CLEAR;
//    [_backView addSubview:_mainMap];
//    [_mainMap mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
}


- (void)creatHeaderBarView {
    self.headerBarView = [[YLYRootView alloc] init];
    _headerBarView.backgroundColor = COLOR_GREEN;
    [_backView addSubview:_headerBarView];
    [_headerBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(YLY6Width(750), YLY6Width(100)));
        make.top.mas_equalTo(STATUEBAR_HEIGHT);
    }];
    
    
    //我的
    self.myButton = [[YLYRootButton alloc] init];
    _myButton.backgroundColor = COLOR_BLUE;
    [_headerBarView addSubview:_myButton];
    [_myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(38));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(36), YLY6Width(36)));
        make.top.mas_equalTo(YLY6Width(32));
    }];
    
    
    //显示城市
    self.cityButton = [[YLYRootButton alloc] init];
    _cityButton.backgroundColor = COLOR_RED;
    [_headerBarView addSubview:_cityButton];
    [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(260));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(230), YLY6Width(100)));
        make.top.mas_equalTo(YLY6Width(0));
    }];
    _cityButton.titleLabel.font = CONSTANT_FONT_BIG;
    
    //信息
    self.messageButton = [[YLYRootButton alloc] init];
    _messageButton.backgroundColor = COLOR_GRAY;
    [_headerBarView addSubview:_messageButton];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(676));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(38), YLY6Width(28)));
        make.top.mas_equalTo(YLY6Width(33));
    }];
    
}


- (void)creatBottomView {
    //回到当前定位点
    self.returnMyLocationBtn = [YLYRootButton creatButtonText:nil titleColor:nil titleFont:nil backgroundImageName:@"回到当前定位" target:self SEL:@selector(backMyLocation)];
    [_backView addSubview:_returnMyLocationBtn];
    _returnMyLocationBtn.backgroundColor = COLOR_BLACK;
    [_returnMyLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(24));
        make.bottom.mas_equalTo(-YLY6Width(415)-SafeAreaBottomHeight);
        make.size.mas_equalTo(CGSizeMake(YLY6Width(54), YLY6Width(54)));
    }];
    
    
    //选择器
    self.orderSwitchButton = [[SwitchButton alloc] init];
    _orderSwitchButton.backgroundColor = COLOR_YELLOW;
    [_backView addSubview:_orderSwitchButton];
    [_orderSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(20));
        make.bottom.mas_equalTo(-YLY6Width(290)-SafeAreaBottomHeight);
        make.size.mas_equalTo(CGSizeMake(YLY6Width(236), YLY6Width(80)));
    }];
    
    
    //地址
    
    
    
    //预定
}

#pragma -mark click
- (void)backMyLocation {
    YLYLog(@"回到当前定位");
    
    
}



@end
