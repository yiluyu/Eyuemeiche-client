//
//  YLYRootView.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLYDefine.h"
#import <Masonry.h>

@class YLYRootView;

typedef void (^viewTouchBlock) (YLYRootView *sender);

@interface YLYRootView : UIView

//touchView事件
@property (nonatomic, readwrite, copy)viewTouchBlock touchBlock;

@end
