//
//  MyInfoModifyViewModel.h
//  Eyuemeiche
//
//  Created by yu on 18/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface MyInfoModifyViewModel : YLYRootModel
@end


//cell
@interface MyInfoModifyCellModel : YLYRootModel

@property (nonatomic, readwrite, copy)NSString *iconImage;//图标
@property (nonatomic, readwrite, copy)NSString *title;//标题
@property (nonatomic, readwrite, copy)NSString *imageURL;//图片地址

@end
