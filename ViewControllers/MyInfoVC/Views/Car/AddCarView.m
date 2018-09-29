//
//  AddCarView.m
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "AddCarView.h"
#import "MyInfoConfig.h"

#pragma -mark item
@interface AddCarCell ()

@end
@implementation AddCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //icon
        self.iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = COLOR_CLEAR;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(13));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(16));
        }];
        
        //信息描述
        self.titleLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                  font:YLY6Font(14)
                                                 color:[UIColor colorWithHexString:@"#666666"]];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(13));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        //箭头
        self.arrowImage = [[UIImageView alloc] init];
        _arrowImage.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_arrowImage];
        self.contentView.backgroundColor = COLOR_CLEAR;
        self.backgroundColor = COLOR_CLEAR;
        [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-20));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(FIT(5));
            make.height.mas_equalTo(FIT(8));
        }];
        
        //详细描述
        self.currentLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                    font:YLY6Font(14)
                                                   color:[UIColor colorWithHexString:@"#666666"]];
        [self.contentView addSubview:_currentLabel];
        [_currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_arrowImage.mas_left).offset(FIT(-13));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#F0F0F0");
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
@interface AddCarView ()

@end
@implementation AddCarView


@end
