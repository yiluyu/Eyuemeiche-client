//
//  MainSlideView.h
//  Eyuemeiche
//
//  Created by yu on 12/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootCell.h"
#import "YLYRootModel.h"

//cell
@interface SlideCell : YLYRootCell
@end

//cellModel
@interface SlideCellModel : YLYRootModel
@end

//header
@interface SlideHeader : YLYRootView
///点击头像
@property (nonatomic, readwrite, copy)void (^headerClickBlock)(void);
@end

//view
@interface MainSlideView : YLYRootView

//点击block
///点击cell回调
@property (nonatomic, readwrite, copy)void (^slideViewCellClick)(NSIndexPath *indexPath);
///点击头部
@property (nonatomic, readwrite, copy)void (^slideViewHeaderClick)(void);

//interface Method
///出现
- (void)show;
///关闭
- (void)hide;

@end
