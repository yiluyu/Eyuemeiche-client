//
//  AddCarViewModel.h
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface AddCarCellModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *iconImage;//照片
@property (nonatomic, readwrite, copy)NSString *title;//颜色
@property (nonatomic, readwrite, copy)NSString *currentDetail;//当前显示
@end

@interface AddCarViewModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *carImage;//照片
@property (nonatomic, readwrite, copy)NSString *color;//颜色
@property (nonatomic, readwrite, copy)NSString *brand;//车型
@property (nonatomic, readwrite, copy)NSString *carNo;//车牌
@end
