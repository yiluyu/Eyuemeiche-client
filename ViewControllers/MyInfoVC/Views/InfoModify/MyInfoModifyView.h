//
//  MyInfoModifyView.h
//  Eyuemeiche
//
//  Created by yu on 18/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootCell.h"

@interface MyInfoModifyView : YLYRootView
@end

/* ----- cell1 ----- */
@interface MyInfoModifyCell1 : YLYRootCell
@property (nonatomic, readwrite, strong)UIImageView *iconImage;//图标
@property (nonatomic, readwrite, strong)UILabel *detailLabel;//项目详情
@property (nonatomic, readwrite, strong)UILabel *titleLabel;//项目描述
@property (nonatomic, readwrite, strong)UIImageView *headerImage;//头像
@end

/* ----- cell2 ----- */
@interface MyInfoModifyCell2 : YLYRootCell
@property (nonatomic, readwrite, strong)UIImageView *iconImage;//图标
@property (nonatomic, readwrite, strong)UILabel *detailLabel;//项目详情
@property (nonatomic, readwrite, strong)UILabel *titleLabel;//项目描述
@property (nonatomic, readwrite, strong)UIImageView *arrowImage;//箭头
@end

/* ----- SexPopView ----- */
@interface SexPopView : YLYRootView

///初始化传值
- (id)initWithArray:(NSArray *)dataArray;

///设定初始值
- (void)pointIndex:(NSInteger)index;

///显示
- (void)show;
///关闭
- (void)hide;

///确认选择
@property (nonatomic, readwrite, copy)void (^sexPopSelectBlcok)(NSInteger index);

@end

