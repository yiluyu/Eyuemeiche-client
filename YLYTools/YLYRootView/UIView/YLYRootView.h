//
//  YLYRootView.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLYRootView;

@interface YLYRootView : UIView

//touchView事件
@property (nonatomic, readwrite, copy)void (^viewTouchBlock)(YLYRootView *sender);

@end
