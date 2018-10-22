//
//  YLYRootModel.h
//  Eyuemeiche
//
//  Created by yu on 07/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLYRegular.h"

@class YLYRootModel;

@protocol YLYRootModelProtocol <NSObject>

@required
///从 Dict 转化成 model
- (void)updateDict:(NSDictionary *)dataDict;

@end

@interface YLYRootModel : NSObject <NSCoding, YLYRootModelProtocol>

@end
