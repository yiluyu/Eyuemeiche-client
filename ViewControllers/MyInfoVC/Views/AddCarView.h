//
//  AddCarView.h
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootLabel.h"

@interface AddCarItem : YLYRootView
@property (nonatomic, readwrite, strong)UIImageView *iconImage;//图片
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;
@property (nonatomic, readwrite, strong)UITextField *inputField;//输入
@property (nonatomic, readwrite, strong)UIImageView *arrowImage;//箭头
@end


@interface AddCarView : YLYRootView

@end
