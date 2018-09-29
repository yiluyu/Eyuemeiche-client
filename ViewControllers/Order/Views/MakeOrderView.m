//
//  MakeOrderView.m
//  Eyuemeiche
//
//  Created by yu on 2018/5/22.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MakeOrderView.h"
#import "MakeOrderViewModel.h"

#pragma -mark 标题item
@interface MakeOrderHeaderItem ()

@end

@implementation MakeOrderHeaderItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE;
        
        self.iconImage = [[YLYRootImageView alloc] init];
        _iconImage.backgroundColor = COLOR_GRAY;
        [self addSubview:_iconImage];
        self.backgroundColor = COLOR_WHITE;
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(16));
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(FIT(19));
        }];
        _iconImage.backgroundColor = COLOR_YELLOW;
        
        self.titleLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                   font:YLY6Font(14)
                                                  color:COLOR_HEX(@"#00CA9D")];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(2));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(FIT(17));
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#F0F0F0");
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}
@end

#pragma -mark 基本信息cell
@interface MakeOrderBaseCell ()

@end

@implementation MakeOrderBaseCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR_WHITE;
        self.contentView.backgroundColor = COLOR_WHITE;
        
        self.iconImage = [[YLYRootImageView alloc] init];
        _iconImage.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_iconImage];

        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(16));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(19));
        }];
        _iconImage.backgroundColor = COLOR_RED;
        
        self.titleLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                   font:YLY6Font(14)
                                                  color:COLOR_HEX(@"#666666")];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(8));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        self.arrow = [[YLYRootImageView alloc] init];
        _arrow.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_arrow];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-12));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(FIT(5));
            make.height.mas_equalTo(FIT(8));
        }];
        
        _arrow.hidden = YES;
        
        self.detailLabel = [YLYRootLabel createLabelText:@"详情"
                                                    font:YLY6Font(14)
                                                   color:COLOR_HEX(@"#999999")];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-12));
            make.centerY.mas_equalTo(_titleLabel);
            make.height.mas_equalTo(_titleLabel);
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#F0F0F0");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)showArrow:(BOOL)show {
    _arrow.hidden = !show;
    if (show == YES) {
        [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-35));
        }];
    } else {
        [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-12));
        }];
    }
    [self layoutIfNeeded];
}

- (void)refreshModel:(MakeOrderBaseModel *)newModel {
    _iconImage.image = [UIImage imageNamed:newModel.icon];
    _titleLabel.text = newModel.title;
    _detailLabel.text = newModel.detail;
}
@end

#pragma -mark 内容cell
@interface MakeOrderContentCell ()

@end

@implementation MakeOrderContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR_WHITE;
        self.contentView.backgroundColor = COLOR_WHITE;
        
        self.iconImage = [[YLYRootImageView alloc] init];
        _iconImage.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_iconImage];

        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(16));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(19));
        }];
        _iconImage.backgroundColor = COLOR_RED;
        
        self.titleLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                   font:YLY6Font(14)
                                                  color:COLOR_HEX(@"#666666")];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(6));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        self.detailLabel = [YLYRootLabel createLabelText:@"详情"
                                                    font:YLY6Font(14)
                                                   color:COLOR_HEX(@"#999999")];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-12));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#F0F0F0");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)refreshModel:(MakeOrderContentModel *)newModel {
    _iconImage.image = [UIImage imageNamed:newModel.icon];
    _titleLabel.text = newModel.title;
    _detailLabel.text = newModel.detail;
}

@end

#pragma -mark 选项cell
@interface MakeOrderSelectCell ()

@end

@implementation MakeOrderSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = COLOR_WHITE;
        self.contentView.backgroundColor = COLOR_WHITE;
        
        self.selectIcon = [[YLYRootImageView alloc] init];
        _selectIcon.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_selectIcon];

        [_selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(16));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(16));
        }];
        _selectIcon.backgroundColor = COLOR_GREEN;
        
        self.iconImage = [[YLYRootImageView alloc] init];
        _iconImage.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_iconImage];

        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_selectIcon.mas_right).offset(FIT(21));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(24));
        }];
        _iconImage.backgroundColor = COLOR_RED;
        
        self.titleLabel = [YLYRootLabel createLabelText:@"项目描述"
                                                   font:YLY6Font(13)
                                                  color:COLOR_HEX(@"#666666")];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(7));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(13));
        }];
        
        self.detailLabel = [YLYRootLabel createLabelText:@"详情"
                                                    font:YLY6Font(14)
                                                   color:COLOR_HEX(@"#999999")];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-12));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(_titleLabel);
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#F0F0F0");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)refreshModel:(MakeOrderSelectModel *)newModel {
    _iconImage.image = [UIImage imageNamed:newModel.icon];
    _titleLabel.text = newModel.title;
    _detailLabel.text = newModel.detail;
    
    //判断select状态
    if (newModel.selected == YES) {
        _selectIcon.image = [UIImage imageNamed:@"icon_makeOrderVC_selected"];
        _selectIcon.backgroundColor = COLOR_GREEN;
    } else {
        _selectIcon.image = [UIImage imageNamed:@"icon_makeOrderVC_unselected"];
        _selectIcon.backgroundColor = COLOR_BLUE;
    }
}

@end

#pragma -mark 照片view
@interface MakeOrderFootView ()
{
    CGFloat scale;
    NSInteger currentIndex;//当前选中图片
    NSInteger imageCount;//显示图片个数
    NSInteger addIndex;//当前加号位置
    
    NSArray *imageArray;//图片数组
}

@property (nonatomic, readwrite, strong)YLYRootButton *photoBtn;//相机
@property (nonatomic, readwrite, strong)YLYRootLabel *desLabel;//描述文字

@property (nonatomic, readwrite, strong)YLYRootImageView *currentBigPhoto;//当前显示图片

@property (nonatomic, readwrite, strong)YLYRootImageView *firstImage;
@property (nonatomic, readwrite, strong)YLYRootImageView *secondImage;
@property (nonatomic, readwrite, strong)YLYRootImageView *thirdImage;
@property (nonatomic, readwrite, strong)YLYRootImageView *fourthImage;

@end

@implementation MakeOrderFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        scale = [BootUnit shareUnit].rate;
        currentIndex = -1;//默认未选中任何image
        imageCount = 0;//下方显示默认下标0
        addIndex = 0;//第一个图片显示加号
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.currentBigPhoto = [[YLYRootImageView alloc] init];
    _currentBigPhoto.backgroundColor = COLOR_WHITE;
    _currentBigPhoto.userInteractionEnabled = YES;
    _currentBigPhoto.layer.cornerRadius = FIT(3);
    [self addSubview:_currentBigPhoto];
    [_currentBigPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(20));
        make.right.mas_equalTo(FIT(-20));
        make.top.mas_equalTo(FIT(15));
        make.height.mas_equalTo(FIT(217));
    }];
    
    self.photoBtn = [YLYRootButton createButtonText:@""
                                         titleColor:nil
                                          titleFont:nil
                                backgroundImageName:@"btn_makeOrderVC_添加当前位置图片"
                                             target:self
                                                SEL:@selector(noPhotoAddBtn)];
    _photoBtn.backgroundColor = COLOR_WHITE;
    _photoBtn.userInteractionEnabled = YES;
    [_currentBigPhoto addSubview:_photoBtn];
    [_photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(21));
        make.height.mas_equalTo(FIT(18));
        make.centerX.mas_equalTo(_currentBigPhoto);
        make.top.mas_equalTo(FIT(88));
    }];
    _photoBtn.backgroundColor = COLOR_YELLOW;
    [_photoBtn setEnlargeEdgeWithTop:FIT(88) right:FIT(150) bottom:FIT(111) left:FIT(150)];
    
    self.desLabel = [YLYRootLabel createLabelText:@"添加当前位置照片"
                                             font:YLY6Font(10)
                                            color:COLOR_HEX(@"#5F5D70")];
    [_currentBigPhoto addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_photoBtn);
        make.top.mas_equalTo(_photoBtn.mas_bottom).offset(FIT(8));
        make.height.mas_equalTo(FIT(16));
    }];
    
    //下方images
    self.firstImage = [[YLYRootImageView alloc] init];
    _firstImage.layer.cornerRadius = FIT(3);
    [self addSubview:_firstImage];
    [_firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_currentBigPhoto);
        make.top.mas_equalTo(_currentBigPhoto.mas_bottom).offset(FIT(9));
        make.width.mas_equalTo(FIT(80));
        make.height.mas_equalTo(FIT(50));
    }];
    YLYRootButton *btn0 = [YLYRootButton createButtonText:@""
                                               titleColor:nil
                                                titleFont:nil
                                      backgroundImageName:@"none"
                                                   target:self
                                                      SEL:@selector(selectBtn:)];
    btn0.tag = 0;
    [_firstImage addSubview:btn0];
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_firstImage);
    }];
    
    self.secondImage = [[YLYRootImageView alloc] init];
    _secondImage.layer.cornerRadius = FIT(3);
    [self addSubview:_secondImage];
    [_secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_firstImage.mas_right).offset(FIT(5));;
        make.top.mas_equalTo(_firstImage);
        make.width.mas_equalTo(_firstImage);
        make.height.mas_equalTo(_firstImage);
    }];
    YLYRootButton *btn1 = [YLYRootButton createButtonText:@""
                                               titleColor:nil
                                                titleFont:nil
                                      backgroundImageName:@"none"
                                                   target:self
                                                      SEL:@selector(selectBtn:)];
    btn1.tag = 1;
    [_secondImage addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_secondImage);
    }];
    
    self.thirdImage = [[YLYRootImageView alloc] init];
    _thirdImage.layer.cornerRadius = FIT(3);
    [self addSubview:_thirdImage];
    [_thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_secondImage.mas_right).offset(FIT(5));;
        make.top.mas_equalTo(_firstImage);
        make.width.mas_equalTo(_firstImage);
        make.height.mas_equalTo(_firstImage);
    }];
    YLYRootButton *btn2 = [YLYRootButton createButtonText:@""
                                               titleColor:nil
                                                titleFont:nil
                                      backgroundImageName:@"none"
                                                   target:self
                                                      SEL:@selector(selectBtn:)];
    btn2.tag = 2;
    [_thirdImage addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_thirdImage);
    }];
    
    self.fourthImage = [[YLYRootImageView alloc] init];
    _fourthImage.layer.cornerRadius = FIT(3);
    [self addSubview:_fourthImage];
    [_fourthImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_thirdImage.mas_right).offset(FIT(5));;
        make.top.mas_equalTo(_firstImage);
        make.width.mas_equalTo(_firstImage);
        make.height.mas_equalTo(_firstImage);
    }];
    YLYRootButton *btn3 = [YLYRootButton createButtonText:@""
                                               titleColor:nil
                                                titleFont:nil
                                      backgroundImageName:@"none"
                                                   target:self
                                                      SEL:@selector(selectBtn:)];
    btn3.tag = 3;
    [_fourthImage addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_fourthImage);
    }];
    
    _firstImage.alpha = 0.0f;
    _secondImage.alpha = 0.0f;
    _thirdImage.alpha = 0.0f;
    _fourthImage.alpha = 0.0f;
    
    _firstImage.userInteractionEnabled = YES;
    _secondImage.userInteractionEnabled = YES;
    _thirdImage.userInteractionEnabled = YES;
    _fourthImage.userInteractionEnabled = YES;
    
    imageArray = @[_firstImage, _secondImage, _thirdImage, _fourthImage];
    
    //刷新显示个数
    [self refreshShowImageCount:imageCount];
    //刷新加号位置
    [self refreshAddPosition];
}

//添加图片
- (void)addPhoto {
    //addIndex 图片赋值
    YLYLog(@"添加图片: %ld", addIndex);
    if (self.addPhotoClickBlock) {
        self.addPhotoClickBlock();
    }
}

//刷新当前显示个数
- (void)refreshShowImageCount:(NSInteger)showCount {
    for (NSInteger i = 0; i < imageArray.count; i ++) {
        YLYRootImageView *imageV = imageArray[i];
        imageV.backgroundColor = COLOR_WHITE;
        if (i <= showCount) {
            imageV.hidden = NO;
            [UIView animateWithDuration:0.3f animations:^{
                imageV.alpha = 1.0f;
            }];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                imageV.alpha = 0.0f;
            } completion:^(BOOL finished) {
                imageV.hidden = YES;
            }];
        }
    }
}

//刷新加号位置
- (void)refreshAddPosition {
    if (addIndex >= imageArray.count) {
        //超出显示范围
        ;
    } else {
        //显示范围内直接取
        YLYRootImageView *imageV = imageArray[addIndex];
        imageV.image = [UIImage imageNamed:@"image_makeOrderVC_addPhoto"];
        imageV.backgroundColor = COLOR_GRAY;
    }
}

//无图片时点击大图默认为第一个添加
- (void)noPhotoAddBtn {
    if (addIndex >= 1) {
        return;
    }
    
    //添加图片
    [self addPhoto];
}

//选择按钮
- (void)selectBtn:(YLYRootButton *)sender {
    if (sender.tag == addIndex) {
        [self addPhoto];
    } else {
        //切换显示图片
        YLYLog(@"当前选择图片: %ld", sender.tag);
        if (sender.tag == currentIndex) {
            return;
        }
        
        if (currentIndex != -1) {
            //上一次选中的取消选中
            YLYRootImageView *imageV = imageArray[currentIndex];
            imageV.layer.borderWidth = FIT(2);
            imageV.layer.borderColor = COLOR_CLEAR.CGColor;
        }
        
        currentIndex = sender.tag;
        YLYRootImageView *imageV = imageArray[currentIndex];
        imageV.layer.borderWidth = FIT(2);
        imageV.layer.borderColor = COLOR_BLUE.CGColor;
        
        //大图显示
        _currentBigPhoto.image = imageV.image;
    }
}

//传入图片
- (void)showImageData:(UIImage *)imageData {
    YLYRootImageView *imageV = imageArray[addIndex];
    imageV.image = imageData;
    
    //如果是添加第一张图片
    if (addIndex == 0) {
        //隐藏按钮以及文字
        _desLabel.hidden = YES;
        _photoBtn.hidden = YES;
        
        //大图显示第一张,并且选中外框
        _currentBigPhoto.image = imageData;
        imageV.layer.borderWidth = FIT(2);
        imageV.layer.borderColor = COLOR_BLUE.CGColor;
        
        currentIndex = 0;
    } else {
        YLYRootImageView *nowImage = imageArray[currentIndex];
        nowImage.layer.borderWidth = FIT(2);
        nowImage.layer.borderColor = COLOR_CLEAR.CGColor;
        
        currentIndex = addIndex;
        YLYRootImageView *imageVNew = imageArray[currentIndex];
        imageVNew.layer.borderWidth = FIT(2);
        imageVNew.layer.borderColor = COLOR_BLUE.CGColor;
        
        //大图更新
        _currentBigPhoto.image = imageData;
    }
    
    //刷新显示个数
    if (imageCount < imageArray.count-1) {
        imageCount ++;
    }
    [self refreshShowImageCount:imageCount];
    
    //刷新加号位置
    addIndex ++;
    [self refreshAddPosition];
}

@end

#pragma -mark bottom
@interface MakeOrderBottomView ()
{
    CGFloat scale;
}

@end

@implementation MakeOrderBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE;
        
        scale = [BootUnit shareUnit].rate;
        YLYRootLabel *moneyDes = [YLYRootLabel createLabelText:@"应付(元): "
                                                          font:YLY6Font(14)
                                                         color:COLOR_HEX(@"#727272")];
        [self addSubview:moneyDes];
        [moneyDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16*scale);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(17*scale);
        }];
        
        self.moneyLabel = [YLYRootLabel createLabelText:@""
                                                   font:YLY6Font(24)
                                                  color:COLOR_HEX(@"#F5A623")];
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16*scale);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(17*scale);
        }];
        
        self.makeOrderBtn = [YLYRootButton createButtonText:@"立即下单"
                                                 titleColor:COLOR_WHITE
                                                  titleFont:YLY6Font(18)
                                        backgroundImageName:@"none"
                                                     target:self
                                                        SEL:@selector(makeOrderPress)];
        _makeOrderBtn.backgroundColor = COLOR_HEX(@"#00CA9D");
        _makeOrderBtn.layer.cornerRadius = FIT(5);
        [self addSubview:_makeOrderBtn];
        [_makeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9*scale);
            make.height.mas_equalTo(35*scale);
            make.width.mas_equalTo(110*scale);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)makeOrderPress {
    if (self.makeOrderClick) {
        self.makeOrderClick();
    }
}

@end

#pragma -mark view
@implementation MakeOrderView

@end
