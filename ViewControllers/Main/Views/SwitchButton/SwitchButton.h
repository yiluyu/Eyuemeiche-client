//
//  SwitchButton.h
//  Eyuemeiche
//
//  Created by yu on 27/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"

typedef enum : NSUInteger {
    /** 现在下单 */
    kOrderTypeNow,
    /** 预约 */
    kOrderTypeReserve,
} ORDERTYPE;

@interface SwitchButton : YLYRootView

@end
