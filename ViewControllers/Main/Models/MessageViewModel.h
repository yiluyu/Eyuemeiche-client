//
//  MessageViewModel.h
//  Eyuemeiche
//
//  Created by yu on 2018/4/24.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

//cellModel
@interface MessageCellModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *type;//状态图标
@property (nonatomic, readwrite, copy)NSString *title;//标题
@property (nonatomic, readwrite, copy)NSString *detail;//内容
@property (nonatomic, readwrite, copy)NSString *date;//时间
@end


//viewModel
@interface MessageViewModel : YLYRootModel

@end
