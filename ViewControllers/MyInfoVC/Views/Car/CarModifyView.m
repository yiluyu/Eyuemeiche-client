//
//  CarModifyView.m
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "CarModifyView.h"
#import "MyInfoConfig.h"

#pragma -mark cell
@implementation CarModifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //图片
        self.carImage = [[UIImageView alloc] init];
        _carImage.backgroundColor = COLOR_GREEN;
        [self.contentView addSubview:_carImage];
        [_carImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(63/2));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(FIT(263/2));
            make.height.mas_offset(FIT(150/2));
        }];
        
        
        YLYRootLabel *label1 = [YLYRootLabel creatLabelText:@"品牌:"
                                                       font:CONSTANT_FONT_DETAIL
                                                      color:COLOR_BLUE];
        [self.contentView addSubview:label1];
        YLYRootLabel *label2 = [YLYRootLabel creatLabelText:@"车牌:"
                                                       font:CONSTANT_FONT_DETAIL
                                                      color:COLOR_BLUE];
        [self.contentView addSubview:label2];
        YLYRootLabel *label3 = [YLYRootLabel creatLabelText:@"颜色:"
                                                       font:CONSTANT_FONT_DETAIL
                                                      color:COLOR_BLUE];
        [self.contentView addSubview:label3];
        
        NSArray *titleArr = @[label1, label2, label3];
        [titleArr mas_distributeViewsAlongAxis:MASAxisTypeVertical
                              withFixedSpacing:0
                                   leadSpacing:FIT(21/2)
                                   tailSpacing:FIT(21/2)];
        [titleArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_carImage.mas_right).offset(FIT(36/2));
        }];
        
        //品牌
        self.brandLabel = [YLYRootLabel creatLabelText:@"默认牌子"
                                                  font:CONSTANT_FONT_DETAIL
                                                 color:COLOR_GRAY];
        [self.contentView addSubview:_brandLabel];
        [_brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label1.mas_right).offset(FIT(5));
            make.centerY.mas_equalTo(label1);
            make.height.mas_equalTo(label1);
        }];
        
        //车牌
        self.carNoLabel = [YLYRootLabel creatLabelText:@"默认车牌"
                                                  font:CONSTANT_FONT_DETAIL
                                                 color:COLOR_GRAY];
        [self.contentView addSubview:_carNoLabel];
        [_carNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_brandLabel);
            make.centerY.mas_equalTo(label2);
            make.height.mas_equalTo(label2);
        }];
        
        //颜色
        self.colorLabel = [YLYRootLabel creatLabelText:@"默认牌子"
                                                  font:CONSTANT_FONT_DETAIL
                                                 color:COLOR_GRAY];
        [self.contentView addSubview:_colorLabel];
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_carNoLabel);
            make.centerY.mas_equalTo(label3);
            make.height.mas_equalTo(label3);
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_VC_BG;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end

#pragma -mark view
@implementation CarModifyView


@end
