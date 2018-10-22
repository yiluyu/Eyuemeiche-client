//
//  MessageView.m
//  Eyuemeiche
//
//  Created by yu on 2018/4/24.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MessageView.h"
#import "MainConfig.h"
#import "YLYBaseViewHeader.h"

#pragma -mark cell
@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.typeImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_typeImage];
        self.contentView.backgroundColor = COLOR_CLEAR;
        self.backgroundColor = COLOR_CLEAR;
        [_typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(37));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(18));
        }];
        
        self.titleLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                  font:YLY6Font(16)
                                                 color:COLOR_HEX(@"#444444")];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_typeImage.mas_right).offset(FIT(30));
            make.top.mas_equalTo(FIT(20));
            make.height.mas_equalTo(FIT(19));
        }];
        
        self.detailLabel = [YLYRootLabel createLabelText:@"详情"
                                                   font:YLY6Font(14)
                                                  color:COLOR_HEX(@"#B5B5B5")];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(FIT(9));
            make.height.mas_equalTo(FIT(17));
        }];
        
        self.dateLabel = [YLYRootLabel createLabelText:@"日期"
                                                  font:YLY6Font(12)
                                                 color:COLOR_HEX(@"#DAD9E2")];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-20));
            make.top.mas_equalTo(FIT(20));
            make.height.mas_equalTo(FIT(14));
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#EFEFEF");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)refreshModel:(MessageCellModel *)model {
    //类型
    if ([model.type integerValue] == 0) {
        _typeImage.backgroundColor = COLOR_GRAY;
    } else {
        _typeImage.backgroundColor = COLOR_RED;
    }
    
    //标题
    self.titleLabel.text = [NSString checkNullString:model.title];
    
    //内容
    self.detailLabel.text = [NSString checkNullString:model.detail];
    
    //时间
    self.dateLabel.text = [NSString checkNullString:model.date];
}

@end


#pragma -mark view
@implementation MessageView

@end
