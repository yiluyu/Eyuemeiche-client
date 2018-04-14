//
//  MainView.h
//  Eyuemeiche
//
//  Created by yu on 26/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import <MAMapKit/MAMapKit.h>

@interface MainView : YLYRootView

///点击侧边栏
@property (nonatomic, readwrite, copy)void (^myBtnBlock)(void);
///点击消息盒子
@property (nonatomic, readwrite, copy)void (^messageBtnBlock)(void);
///进入订单制作
@property (nonatomic, readwrite, copy)void (^callBtnBlock)(NSDictionary *dict);

///发起坐标搜索请求
@property (nonatomic, readwrite, copy)void (^mapSearchBlock)(CLLocationCoordinate2D location);


/* 属性 */
@property (nonatomic, readwrite, strong)MAMapView *mapView;//地图


@end
