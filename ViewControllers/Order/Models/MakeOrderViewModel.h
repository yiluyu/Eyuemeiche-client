//
//  MakeOrderViewModel.h
//  Eyuemeiche
//
//  Created by yu on 2018/5/22.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface MakeOrderBaseModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *icon;//图标
@property (nonatomic, readwrite, copy)NSString *title;//标题
@property (nonatomic, readwrite, copy)NSString *detail;//内容
@end

@interface MakeOrderContentModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *icon;//图标
@property (nonatomic, readwrite, copy)NSString *title;//标题
@property (nonatomic, readwrite, copy)NSString *detail;//内容
@end

@interface MakeOrderSelectModel : YLYRootModel
@property (nonatomic, readwrite, assign)BOOL selected;//是否被选中

@property (nonatomic, readwrite, copy)NSString *icon;//图标
@property (nonatomic, readwrite, copy)NSString *title;//标题
@property (nonatomic, readwrite, copy)NSString *detail;//内容
@end


@interface MakeOrderViewModel : YLYRootModel

@end
