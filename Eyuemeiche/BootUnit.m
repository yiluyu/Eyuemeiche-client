//
//  BootUnit.m
//  Eyuemeiche
//
//  Created by yu on 12/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "BootUnit.h"
#import "YLYRootTabbarController.h"

@interface BootUnit ()

@property (nonatomic, readwrite, strong)YLYRootTabbarController *tabbar;

@end

@implementation BootUnit

+ (instancetype)shareUnit {
    static BootUnit *unit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unit = [[BootUnit allocWithZone:NULL] init];
        
        [unit creatTabbar];
    });
    
    return unit;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareUnit];
}

//创建tabbar
- (void)creatTabbar {
    self.tabbar = [[YLYRootTabbarController alloc] init];
    _tabbar.selectedIndex = 0;
    _tabbar.tabBar.hidden = YES;
}






@end
