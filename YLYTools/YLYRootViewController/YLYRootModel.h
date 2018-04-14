//
//  YLYRootModel.h
//  Eyuemeiche
//
//  Created by yu on 07/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLYRootModel : NSObject <NSCoding>

///从 Dict 转化成 model
- (instancetype)initWithDict:(NSDictionary *)dataDict;

@end
