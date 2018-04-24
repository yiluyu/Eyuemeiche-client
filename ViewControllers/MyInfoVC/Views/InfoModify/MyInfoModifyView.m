//
//  MyInfoModifyView.m
//  Eyuemeiche
//
//  Created by yu on 18/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MyInfoConfig.h"

@implementation MyInfoModifyView

@end

#pragma -mark cell1
@interface MyInfoModifyCell1 ()

@end
@implementation MyInfoModifyCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //icon
        self.iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = COLOR_CLEAR;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(14));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(19));
        }];
        
        //信息描述
        self.titleLabel = [YLYRootLabel creatLabelText:@"项目描述"
                                                  font:YLY6Font(14)
                                                 color:[UIColor colorWithHexString:@"#666666"]];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(13));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        //头像
        self.headerImage = [[UIImageView alloc] init];
        _headerImage.backgroundColor = COLOR_RED;
        _headerImage.layer.cornerRadius = FIT(60/2);
        _headerImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_headerImage];
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-26));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(60));
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

#pragma -mark cell2
@interface MyInfoModifyCell2 ()

@end
@implementation MyInfoModifyCell2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //icon
        self.iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = COLOR_CLEAR;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(14));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(19));
        }];
        
        //信息描述
        self.titleLabel = [YLYRootLabel creatLabelText:@"项目描述"
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
            make.right.mas_equalTo(FIT(-26));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(FIT(5));
            make.height.mas_equalTo(FIT(8));
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

#pragma -mark sexPopView
@interface SexPopView () <UIPickerViewDelegate ,UIPickerViewDataSource>
{
    NSArray *pickerData;
    NSInteger selectIndex;
}

@property (nonatomic, readwrite, strong)YLYRootView *backView;//背景底色
@property (nonatomic, readwrite, strong)YLYRootView *whiteView;//白色view
@property (nonatomic, readwrite, strong)UIPickerView *pickerView;//选择器

@end

@implementation SexPopView

- (instancetype)init {
    if (self = [super init]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        self.hidden = YES;
        self.backgroundColor = COLOR_CLEAR;
        self.alpha = 0.0f;
        
        pickerData = @[@"男", @"女"];
        
        [self creatSubViews];
        [self show];
    }
    return self;
}

- (void)creatSubViews {
    self.backView = [[YLYRootView alloc] init];
    _backView.backgroundColor = COLOR_BLACK;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    SELF_WEAK();
    _backView.viewTouchBlock = ^(YLYRootView *sender) {
        [weakSelf hide];
    };
    
    self.whiteView = [[YLYRootView alloc] init];
    _whiteView.backgroundColor = COLOR_WHITE;
    [self addSubview:_whiteView];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(241));
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
    }];
    
    YLYRootButton *cancel = [YLYRootButton creatButtonText:@"取消"
                                                titleColor:COLOR_HEX(@"#9B99A9")
                                                 titleFont:CONSTANT_FONT_SMALL
                                       backgroundImageName:@"none"
                                                    target:self
                                                       SEL:@selector(cancelClick)];
    [_whiteView addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(14));
        make.height.mas_equalTo(FIT(17));
        make.top.mas_equalTo(FIT(14));
    }];
    
    YLYRootButton *sure = [YLYRootButton creatButtonText:@"确认"
                                                titleColor:COLOR_GREEN
                                                 titleFont:CONSTANT_FONT_SMALL
                                       backgroundImageName:@"none"
                                                    target:self
                                                       SEL:@selector(sureClick)];
    [_whiteView addSubview:sure];
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-14));
        make.height.mas_equalTo(FIT(17));
        make.top.mas_equalTo(FIT(14));
    }];
    
    //pickerView
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickerView reloadAllComponents];
    [_whiteView addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(183));
    }];
}

- (void)sureClick {
    //读取当前picker选择
    
    
    [self hide];
}

- (void)cancelClick {
    [self hide];
}

- (void)pointIndex:(NSInteger)index {
    selectIndex = index;
    
    [_pickerView selectRow:selectIndex inComponent:0 animated:YES];
}

- (void)show {
    self.hidden = NO;
    
    SELF_WEAK();
    [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
        weakSelf.alpha = 1.0f;
        weakSelf.backView.alpha = 0.3f;
    }];
}
- (void)hide {
    if (self.backView.alpha < 0.3f) {
        return;
    }
    
    SELF_WEAK();
    [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
        weakSelf.alpha = 0.0f;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

#pragma -mark pickerDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return FIT(35);
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerData[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectIndex = row;
    if (self.sexPopSelectBlcok) {
        self.sexPopSelectBlcok(selectIndex);
    }
}


@end
