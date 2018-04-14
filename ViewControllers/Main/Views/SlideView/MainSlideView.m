//
//  MainSlideView.m
//  Eyuemeiche
//
//  Created by yu on 12/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MainSlideView.h"
#import "MainConfig.h"

/* -------------------------*/
#pragma -mark --------- Cell ---------
/* -------------------------*/
@interface SlideCell ()
@property (nonatomic, readwrite, strong)UIImageView *iconImage;//icon
@property (nonatomic, readwrite, strong)UILabel *detailLabel;//描述
@end

@implementation SlideCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(31));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(18));
        }];
        
        self.detailLabel = [YLYRootLabel creatLabelText:@"项目描述"
                                                   font:YLY6Font(16)
                                                  color:COLOR_BLACK];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(8));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(19));
        }];
    }
    return self;
}

@end

/* -------------------------*/
#pragma -mark --------- CellModel ---------
/* -------------------------*/
@interface SlideCellModel ()
@property (nonatomic, readwrite, copy)NSString *iconName;//icon图片
@property (nonatomic, readwrite, copy)NSString *title;//内容
@end

@implementation SlideCellModel

@end


/* -------------------------*/
#pragma -mark --------- header ---------
/* -------------------------*/
@interface SlideHeader ()
@property (nonatomic, readwrite, strong)UIImageView *headerImage;//头像
@property (nonatomic, readwrite, strong)UILabel *nickNameLabel;//昵称
@property (nonatomic, readwrite, strong)UILabel *phoneLabel;//手机
@end

@implementation SlideHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_RED;
        
        self.headerImage = [[UIImageView alloc] init];
        _headerImage.backgroundColor = COLOR_BLUE;
        [self addSubview:_headerImage];
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(18));
            make.top.mas_equalTo(FIT(59));
            make.width.height.mas_equalTo(FIT(60));
        }];
//        _headerImage.frame = YLY6Rect(18, 59, 60, 60);
        _headerImage.layer.cornerRadius = FIT(60/2);
        _headerImage.layer.masksToBounds = YES;
        
        self.nickNameLabel = [YLYRootLabel creatLabelText:@"用户昵称"
                                                     font:YLY6Font(16)
                                                    color:COLOR_WHITE];
        [self addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImage.mas_right).offset(FIT(8));
            make.top.mas_equalTo(_headerImage.mas_top).offset(FIT(11));
            make.height.mas_equalTo(FIT(19));
        }];
//        _nickNameLabel.frame = YLY6Rect(86, 70, 146, 19);
        self.phoneLabel = [YLYRootLabel creatLabelText:@"手机号131xxxxxx"
                                                  font:YLY6Font(12)
                                                 color:COLOR_WHITE];
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nickNameLabel);
            make.top.mas_equalTo(_nickNameLabel.mas_bottom).offset(FIT(3));
            make.height.mas_equalTo(FIT(14));
        }];
//        _phoneLabel.frame = YLY6Rect(86, 92, 146, 14);
        
        //触发事件
        YLYRootButton *allBtn = [YLYRootButton creatButtonText:nil
                                                    titleColor:nil
                                                     titleFont:nil
                                           backgroundImageName:nil
                                                        target:self
                                                           SEL:@selector(clickHeader)];
        [self addSubview:allBtn];
        [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.top.mas_equalTo(_headerImage);
            make.right.mas_equalTo(_nickNameLabel);
        }];
        allBtn.backgroundColor = COLOR_CLEAR;
    }
    return self;
}

- (void)clickHeader {
    if (self.headerClickBlock) {
        self.headerClickBlock();
    }
}

@end

/* -------------------------*/
#pragma -mark --------- view ---------
/* -------------------------*/
@interface MainSlideView () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableDataArray;//数据列表
    NSArray *iconArray;//icon列表
}

@property (nonatomic, readwrite, strong)YLYRootView *backView;//背景底色
@property (nonatomic, readwrite, strong)YLYRootView *sideView;//侧边栏
@property (nonatomic, readwrite, strong)UITableView *tableView;//列表
@property (nonatomic, readwrite, strong)SlideHeader *headerView;//头部

@end

@implementation MainSlideView

- (instancetype)init {
    if (self = [super initWithFrame:YLY6Rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        self.backgroundColor = COLOR_CLEAR;
        self.alpha = 0.0f;
        NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:4];
        NSArray *titleArr = @[@"我的订单", @"免责说明", @"联系客服", @"关于我们"];
        for (NSInteger i = 0; i < titleArr.count; i ++) {
            SlideCellModel *model = [[SlideCellModel alloc] init];
            model.title = titleArr[i];
            model.iconName = [NSString stringWithFormat:@"icon_%@", titleArr[i]];
            [tmpArr addObject:model];
        }
        tableDataArray = [NSArray arrayWithArray:tmpArr];
        
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    SELF_WEAK();
    
    self.backView = [[YLYRootView alloc] initWithFrame:YLY6Rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor = COLOR_BLACK;
    _backView.alpha = 0.0f;
    [self addSubview:_backView];
    _backView.viewTouchBlock = ^(YLYRootView *sender) {
        [weakSelf hide];
    };
    
    self.sideView = [[YLYRootView alloc] initWithFrame:YLY6Rect(-232, 0, 232, SCREEN_HEIGHT)];
    _sideView.backgroundColor = COLOR_CLEAR;
    [self addSubview:_sideView];
    
    //背景
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"侧边栏绿色背景"]];
    bgImage.backgroundColor = [UIColor colorWithHexString:@"#AEEFAA"];
    [_sideView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //底部
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"侧边栏logo"]];
    logoImage.backgroundColor = COLOR_RED;
    [_sideView addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT(-30)-SafeAreaBottomHeight);
        make.centerX.mas_equalTo(_sideView);
        make.height.mas_equalTo(FIT(25));
        make.width.mas_equalTo(FIT(86));
    }];
    
    //header
    self.headerView = [[SlideHeader alloc] initWithFrame:YLY6Rect(0, 0, 232, 175)];
    _headerView.headerClickBlock = ^{
        if (weakSelf.slideViewHeaderClick) {
            weakSelf.slideViewHeaderClick();
        }
    };
    
    //table
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.backgroundColor = COLOR_YELLOW;
    _tableView.tableHeaderView = _headerView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[SlideCell class] forCellReuseIdentifier:@"SlideCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_sideView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STATUEBAR_HEIGHT);
        make.bottom.mas_equalTo(logoImage.mas_top);
    }];

    
    
}

#pragma -mark tableDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.00001f;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.00001f;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(40);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SlideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SlideCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SlideCell alloc] initWithStyle:UITableViewCellStyleValue2
                                reuseIdentifier:@"SlideCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SlideCellModel *model = tableDataArray[indexPath.row];
    
    cell.iconImage.image = [UIImage imageNamed:model.iconName];
    cell.detailLabel.text = model.title;
    
    return cell;
}


- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    SELF_WEAK();
    [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
        weakSelf.alpha = 1.0f;
        weakSelf.backView.alpha = 0.2f;
        weakSelf.sideView.frame = YLY6Rect(0, 0, 232, SCREEN_HEIGHT);
    }];
}
- (void)hide {
    if (self.backView.alpha < 0.2f) {
        return;
    }
    
    SELF_WEAK();
    [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
        weakSelf.alpha = 0.0f;
        weakSelf.sideView.frame = YLY6Rect(-232, 0, 232, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
