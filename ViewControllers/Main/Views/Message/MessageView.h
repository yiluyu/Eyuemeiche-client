//
//  MessageView.h
//  Eyuemeiche
//
//  Created by yu on 2018/4/24.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootCell.h"
#import "YLYRootLabel.h"

@interface MessageCell : YLYRootCell

@property (nonatomic, readwrite, strong)UIImageView *typeImage;//标识
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;//主标题
@property (nonatomic, readwrite, strong)YLYRootLabel *detailLabel;//副标题
@property (nonatomic, readwrite, strong)YLYRootLabel *dateLabel;//时间

@end

@interface MessageView : YLYRootView

@end
