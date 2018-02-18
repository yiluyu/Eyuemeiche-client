//
//  YLYHelper.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYHelper.h"
#import <Reachability/Reachability.h>

@implementation YLYHelper

+ (void)registerNotificationName:(NSString *)notiName observer:(id)observer event:(notificationBlock)block {
    [[NSNotificationCenter defaultCenter] addObserverForName:kReachabilityChangedNotification
                                                      object:observer
                                                       queue:[NSOperationQueue mainQueue] /*暂时放在主线程*/ usingBlock:^(NSNotification * _Nonnull note) {
                                                           if (block != nil) {
                                                               block(note);
                                                           }
                                                       }
     ];
}

+ (void)removeNotificationName:(NSString *)notiName observer:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:notiName
                                                  object:nil];
}



@end
