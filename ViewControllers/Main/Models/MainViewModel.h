//
//  MainViewModel.h
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface MainViewModel : YLYRootModel

@end

//cellModel
@interface SlideCellModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *iconName;//icon图片
@property (nonatomic, readwrite, copy)NSString *title;//内容
@end
