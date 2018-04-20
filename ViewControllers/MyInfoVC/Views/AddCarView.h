//
//  AddCarView.h
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootLabel.h"
#import "YLYRootCell.h"

@interface AddCarCell : YLYRootCell
@property (nonatomic, readwrite, strong)UIImageView *iconImage;//图片
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;//标题描述
@property (nonatomic, readwrite, strong)YLYRootLabel *currentLabel;//当前cell的内容
@end


@interface AddCarView : YLYRootView

@end
