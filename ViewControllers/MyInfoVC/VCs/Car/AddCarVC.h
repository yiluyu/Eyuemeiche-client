//
//  AddCarVC.h
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootViewController.h"

@protocol AddCarDelegate <NSObject>
///刷新数据
- (void)callBackRefreshData;
@end

typedef NS_ENUM(NSInteger, ENUM_AddCarVCType) {
    kNormal,    //正常添加
    kModify     //修改原来的
};

@interface AddCarVC : YLYRootViewController

/*
 dict可能要传入carid
 */

@property (nonatomic, readwrite, assign)ENUM_AddCarVCType type;

@property (nonatomic, readwrite, weak)id <AddCarDelegate>delegate;


@end
