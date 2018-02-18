//
//  BootUnit.h
//  Eyuemeiche
//
//  Created by yu on 12/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLYRootTabbarController;

@interface BootUnit : NSObject

+ (instancetype)shareUnit;

/** tabbar */
@property (nonatomic, readonly, strong)YLYRootTabbarController *tabbar;


@end
