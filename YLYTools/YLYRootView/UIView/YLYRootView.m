//
//  YLYRootView.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYDefine.h"

@implementation YLYRootView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fatherViewTap)];
//        [self addGestureRecognizer:tap];
        
    }
    return self;
}

//- (void)fatherViewTap {
//    if (self.tapBlock != nil) {
//        self.tapBlock(self);
//    }
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.viewTouchBlock != nil) {
        self.viewTouchBlock(self);
    }
}


@end
