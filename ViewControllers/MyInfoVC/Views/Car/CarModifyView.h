//
//  CarModifyView.h
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootCell.h"
#import "YLYRootLabel.h"

@interface CarModifyCell : YLYRootCell
@property (nonatomic, readwrite, strong)UIImageView *carImage;//图片
@property (nonatomic, readwrite, strong)YLYRootLabel *brandLabel;//品牌
@property (nonatomic, readwrite, strong)YLYRootLabel *carNoLabel;//车牌
@property (nonatomic, readwrite, strong)YLYRootLabel *colorLabel;//颜色
@end






@interface CarModifyView : YLYRootView

@end
