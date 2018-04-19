//
//  AddCarModel.h
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface AddCarModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *carImage;//照片
@property (nonatomic, readwrite, copy)NSString *color;//颜色
@property (nonatomic, readwrite, copy)NSString *brand;//车型
@property (nonatomic, readwrite, copy)NSString *carNo;//车牌
@end
