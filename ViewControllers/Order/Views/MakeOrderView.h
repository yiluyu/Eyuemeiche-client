//
//  MakeOrderView.h
//  Eyuemeiche
//
//  Created by yu on 2018/5/22.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "CommonConfig.h"
@class MakeOrderBaseModel;
@class MakeOrderContentModel;
@class MakeOrderSelectModel;

@interface MakeOrderHeaderItem : YLYRootView
@property (nonatomic, readwrite, strong)YLYRootImageView *iconImage;//图标
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;//标题
@end

@interface MakeOrderBaseCell : UITableViewCell
@property (nonatomic, readwrite, strong)YLYRootImageView *iconImage;//图标
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;//标题
@property (nonatomic, readwrite, strong)YLYRootLabel *detailLabel;//内容
@property (nonatomic, readwrite, strong)YLYRootImageView *arrow;//箭头

///是否显示箭头
- (void)showArrow:(BOOL)show;
///加载数据
- (void)refreshModel:(MakeOrderBaseModel *)newModel;
@end

@interface MakeOrderContentCell : UITableViewCell
@property (nonatomic, readwrite, strong)YLYRootImageView *iconImage;//图标
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;//标题
@property (nonatomic, readwrite, strong)YLYRootLabel *detailLabel;//内容
///加载数据
- (void)refreshModel:(MakeOrderContentModel *)newModel;
@end

@interface MakeOrderSelectCell : UITableViewCell
@property (nonatomic, readwrite, strong)YLYRootImageView *selectIcon;//选择图标
@property (nonatomic, readwrite, strong)YLYRootImageView *iconImage;//图标
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;//标题
@property (nonatomic, readwrite, strong)YLYRootLabel *detailLabel;//内容
///加载数据
- (void)refreshModel:(MakeOrderSelectModel *)newModel;
@end

//照片view
@interface MakeOrderFootView : YLYRootView
///添加图片
@property (nonatomic, readwrite, copy)void (^addPhotoClickBlock)(void);

///传入图片
- (void)showImageData:(UIImage *)imageData;
@end

//底部
@interface MakeOrderBottomView : YLYRootView
@property (nonatomic, readwrite, strong)YLYRootLabel *moneyLabel;
@property (nonatomic, readwrite, strong)YLYRootButton *makeOrderBtn;

@property (nonatomic, readwrite, copy)void (^makeOrderClick)(void);

@end


@interface MakeOrderView : YLYRootView

@end
