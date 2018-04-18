//
//  UIButton+ExtentMethod.m
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "UIButton+ExtentMethod.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, readwrite, assign)NSTimeInterval lastClickTime;//最后一次点击btn时间

@end

@implementation UIButton (ExtentMethod)

static const char *button_actionIntervalTime = "button_actionIntervalTime";
static const char *button_clickTime = "button_clickTime";

//手动增加 actionIntervalTime get方法
- (NSTimeInterval)actionIntervalTime {
    return [objc_getAssociatedObject(self, button_actionIntervalTime) doubleValue];
}
//手动增加 actionIntervalTime set方法
- (void)setActionIntervalTime:(NSTimeInterval)intervalTime {
    objc_setAssociatedObject(self, button_actionIntervalTime, @(intervalTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//新增 lastClickTime set方法
- (void)setLastClickTime:(NSTimeInterval)lastClickTime {
    objc_setAssociatedObject(self, button_clickTime, @(lastClickTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//新增 lastClickTime get方法
- (NSTimeInterval)lastClickTime {
    return [objc_getAssociatedObject(self, button_clickTime) doubleValue];
}


//添加间隔
+ (void)load {
    //确保只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //selector
        SEL systemSEL = @selector(sendAction:to:forEvent:);
        SEL newSEL = @selector(newSendAction:to:forEvent:);
        //method
        Method systemMethod = class_getInstanceMethod([self class], systemSEL);
        Method newMethod = class_getInstanceMethod([super class], newSEL);
        //尝试对 sysSEL 添加新的 Method
        /*
         *  but will not replace an existing implementation in this class.
         *  To change an existing implementation, use method_setImplementation.
         */
        BOOL addSuccess = class_addMethod(self,
                                          systemSEL,
                                          method_getImplementation(newMethod),
                                          method_getTypeEncoding(newMethod));
        if (addSuccess == YES) {
            //如果添加方法成功, 则类中没有 newMethod 并且成功将 newMethod地址 给 sysSEL 做好了映射.
            //那么就将 sysMethod地址 给 newSEL 做映射, 以便在之后需要执行 sysMethod 时可以找到
            class_replaceMethod([self class],
                                newSEL,
                                method_getImplementation(systemMethod),
                                method_getTypeEncoding(systemMethod));
        } else {
            //添加 newMethod 失败, 类中已经有这个方法. 直接将方法交换
            method_exchangeImplementations(systemMethod, newMethod);
        }
    });
}

//newMethod
- (void)newSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([target respondsToSelector:action] == NO) {
        return;
    }
    
    NSTimeInterval intVal = self.actionIntervalTime;
    if (intVal <= 0 || intVal > 10) {
        //设置默认的间隔时间 1.0f
        self.actionIntervalTime = 1.0f;
    }
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970]*1000;
    if (now - self.lastClickTime <= intVal*1000) {
        //在间隔时间内不执行 Method
        return;
    } else {
        //记录最新点击时间
        self.lastClickTime = now;
    }
    
    //在 +load 方法里已经将 sysSEL->newMethod, newSEL->sysMethod 交换过了
    //这里需要执行系统的 UIButton 响应方法, 直接找 newSEL 即可
    [self newSendAction:action to:target forEvent:event];
}

@end
